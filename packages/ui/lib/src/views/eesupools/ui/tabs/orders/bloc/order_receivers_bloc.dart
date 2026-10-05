import 'package:bloc/bloc.dart';
import 'package:data/eesupools/models/eesupool_member.dart';
import 'package:data/eesupools/models/receiver_role.dart';
import 'package:data/eesupools/repository/eesupool_orders_repo.dart';
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
    // quick changes can't land out of order and leave the older one saved,
    // and a failed save is rolled back and reported instead of the screen
    // showing a role that was never stored.
    on<OrderReceiverChange>(
      (event, emit) => switch (event) {
        OrderReceiverAdded() => _onAdded(event, emit),
        OrderReceiverRemoved() => _onRemoved(event, emit),
        OrderReceiverRoleAssigned() => _onRoleAssigned(event, emit),
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
    // of the same member can fail to compare equal and slip past this
    // dedup check.
    if (current.receivers.any((r) => r.memberId == event.member.memberId)) {
      return;
    }
    if (event.member.isVerified == false) {
      emit(current.withError(
        '${event.member.fullName} is not verified and cannot be '
        'assigned a role.',
      ));
      return;
    }

    final receivers = [...current.receivers, event.member];
    // Every receiver must have a role, so new ones start as Receiver.
    final roles = {
      ...current.roles,
      event.member.memberId: ReceiverRole.receiver,
    };
    emit(OrderReceiversLoaded(receivers, roles));

    final saved = await _repository.updatePoolOrderReceivers(
      event.orderId,
      receivers.map((e) => e.memberId).toList(),
    );
    final error = await saved.fold(
      (l) async => l.message,
      (_) async => (await _repository.updateOrderReceiverRoles(
        event.orderId,
        roles,
      ))
          .fold((l) => l.message, (_) => null),
    );
    if (error != null) emit(current.withError(error));
  }

  Future<void> _onRemoved(
    OrderReceiverRemoved event,
    Emitter<OrderReceiversState> emit,
  ) async {
    if (state is! OrderReceiversLoaded) return;
    final current = state as OrderReceiversLoaded;
    final receivers = [...current.receivers]
      ..removeWhere((r) => r.memberId == event.member.memberId);
    // Drop the removed member's role too, so a re-added member doesn't
    // inherit a stale role.
    final roles = {...current.roles}..remove(event.member.memberId);
    emit(OrderReceiversLoaded(receivers, roles));

    final saved = await _repository.updatePoolOrderReceivers(
      event.orderId,
      receivers.map((e) => e.memberId).toList(),
    );
    String? error = saved.fold((l) => l.message, (_) => null);
    if (error == null && roles.length != current.roles.length) {
      error = (await _repository.updateOrderReceiverRoles(
        event.orderId,
        roles,
      ))
          .fold((l) => l.message, (_) => null);
    }
    if (error != null) emit(current.withError(error));
  }

  Future<void> _onRoleAssigned(
    OrderReceiverRoleAssigned event,
    Emitter<OrderReceiversState> emit,
  ) async {
    if (state is! OrderReceiversLoaded) return;
    final current = state as OrderReceiversLoaded;
    final roles = {...current.roles, event.memberId: event.role};
    emit(OrderReceiversLoaded(current.receivers, roles));

    final saved =
        await _repository.updateOrderReceiverRoles(event.orderId, roles);
    saved.fold(
      (l) => emit(current.withError(l.message)),
      (_) {},
    );
  }
}
