import 'package:bloc/bloc.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/models/receiver_role.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

part 'order_receivers_event.dart';
part 'order_receivers_state.dart';

class OrderReceiversBloc
    extends Bloc<OrderReceiversEvent, OrderReceiversState> {
  final EESUpoolRepository _repository;
  OrderReceiversBloc(this._repository) : super(OrderReceiversLoading()) {
    on<OrderReceiversFetched>((event, emit) async {
      final results = await _repository.fetchEESUpoolMembersByIdsArray(
        event.receivers,
      );
      results.fold((left) {
        emit(OrderReceiversError(left));
      }, (right) {
        emit(OrderReceiversLoaded(right, event.initialRoles));
      });
    });

    // Changes are processed one at a time and each save is awaited, so two
    // quick changes can't land out of order, and a failed save is rolled back
    // and reported instead of the screen showing something never stored.
    on<OrderReceiverChange>(
      (event, emit) => switch (event) {
        OrderReceiverAdded() => _onAdded(event, emit),
        OrderReceiverRemoved() => _onRemoved(event, emit),
      },
      transformer: (events, mapper) => events.asyncExpand(mapper),
    );
  }

  Future<void> _onAdded(
    OrderReceiverAdded event,
    Emitter<OrderReceiversState> emit,
  ) async {
    if (state is! OrderReceiversLoaded) return;
    final current = state as OrderReceiversLoaded;

    // Compare by memberId rather than whole-object equality: the member
    // being added comes from a different fetch (the member-picker
    // dialog) than the ones already in `receivers`, and freezed's
    // generated `==` requires every field to match, so two instances
    // of the same member can fail to compare equal.
    if (current.receivers.any((r) => r.memberId == event.member.memberId)) {
      emit(current.withError(
        '${event.member.fullName} is already a receiver on this order.',
      ));
      return;
    }
    if (event.member.isVerified == false) {
      emit(current.withError(
        '${event.member.fullName} is not verified and cannot be '
        'assigned as a receiver.',
      ));
      return;
    }

    // The server adds the receiver and their Bulk Order Receiver role in one
    // step, so the two can never disagree.
    final saved = await _repository.addOrderReceiver(
      event.orderId,
      event.member.memberId,
    );
    saved.fold(
      (l) => emit(current.withError(l.message)),
      (_) => emit(OrderReceiversLoaded(
        [...current.receivers, event.member],
        {...current.roles, event.member.memberId: ReceiverRole.receiver},
      )),
    );
  }

  Future<void> _onRemoved(
    OrderReceiverRemoved event,
    Emitter<OrderReceiversState> emit,
  ) async {
    if (state is! OrderReceiversLoaded) return;
    final current = state as OrderReceiversLoaded;

    final saved = await _repository.removeOrderReceiver(
      event.orderId,
      event.member.memberId,
    );
    saved.fold(
      (l) => emit(current.withError(l.message)),
      (_) => emit(OrderReceiversLoaded(
        [...current.receivers]
          ..removeWhere((r) => r.memberId == event.member.memberId),
        {...current.roles}..remove(event.member.memberId),
      )),
    );
  }
}
