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

    on<OrderReceiverAdded>((event, emit) {
      if (state is OrderReceiversLoaded) {
        List<EESUpoolMember> receivers = [
          ...(state as OrderReceiversLoaded).receivers
        ];
        // Compare by memberId rather than whole-object equality: the member
        // being added comes from a different fetch (the member-picker
        // dialog) than the ones already in `receivers`, and freezed's
        // generated `==` requires every field to match, so two instances
        // of the same member can fail to compare equal and slip past this
        // dedup check.
        final alreadyAdded =
            receivers.any((r) => r.memberId == event.member.memberId);
        if (!alreadyAdded) {
          receivers.add(event.member);
          final ids = receivers.map((e) => e.memberId).toList();
          _repository.updatePoolOrderReceivers(event.orderId, ids);
          emit(
            OrderReceiversLoaded(
              receivers,
              (state as OrderReceiversLoaded).roles,
            ),
          );
        }
      }
    });

    on<OrderReceiverRemoved>((event, emit) {
      if (state is OrderReceiversLoaded) {
        final current = state as OrderReceiversLoaded;
        List<EESUpoolMember> receivers = [...current.receivers];
        receivers.removeWhere((r) => r.memberId == event.member.memberId);
        final ids = receivers.map((e) => e.memberId).toList();
        _repository.updatePoolOrderReceivers(event.orderId, ids);

        // Drop the removed member's role too, and persist that cleanup so
        // a re-added member doesn't inherit a stale role.
        final roles = {...current.roles}..remove(event.member.memberId);
        if (roles.length != current.roles.length) {
          _repository.updateOrderReceiverRoles(event.orderId, roles);
        }
        emit(OrderReceiversLoaded(receivers, roles));
      }
    });

    on<OrderReceiverRoleAssigned>((event, emit) {
      if (state is OrderReceiversLoaded) {
        final current = state as OrderReceiversLoaded;
        final roles = {...current.roles};
        if (event.role == null) {
          roles.remove(event.memberId);
        } else {
          roles[event.memberId] = event.role!;
        }
        _repository.updateOrderReceiverRoles(event.orderId, roles);
        emit(OrderReceiversLoaded(current.receivers, roles));
      }
    });
  }
}
