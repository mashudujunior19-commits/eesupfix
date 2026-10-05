import 'package:bloc/bloc.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:data/eesupools/repository/eesupool_orders_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:data/orders/models/order.dart';
import 'package:data/orders/repository/order_repository.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

part 'member_orders_event.dart';
part 'member_orders_state.dart';

class MemberOrdersBloc extends Bloc<MemberOrdersEvent, MemberOrdersState> {
  final EESUpoolRepository _poolRepository;
  final OrderRepository _orderRepository;
  MemberOrdersBloc(this._poolRepository, this._orderRepository)
      : super(OrdersLoading()) {
    on<MemberOrdersFetched>((event, emit) async {
      // emit(OrdersLoading());
      ///get the orders stream
      final stream = _orderRepository.streamPoolOrders(
        orderId: event.orderId,
        statuses: event.initStatuses,
        limit: event.initLimit,
      );

      //using the forEach event method to emit the appropriate state
      await emit.forEach(
        stream,
        onData: (data) {
          return data.fold((l) {
            return OrdersError(l);
          }, (r) {
            return OrdersLoaded(r);
          });
        },
      );
    });

    on<MemberOrderAssignmentsUpdated>((event, emit) async {
      if (state is OrdersLoaded) {
        final previous = (state as OrdersLoaded).orders;
        List<Order> orders = [...previous];
        final index = orders.indexWhere((e) => e.id == event.orderId);
        if (index != -1) {
          final copy = orders[index].copyWith(
            assignments: event.assignments,
          );
          orders[index] = copy;
          emit(OrdersLoaded(orders));

          // Roll back to what's actually stored if the save is rejected
          // (e.g. an unverified member, or someone packing their own order).
          final saved = await _poolRepository.updateOrderAssignments(
              event.assignments, event.orderId);
          saved.fold(
            (l) => emit(OrdersLoaded(previous, saveError: l.message)),
            (_) {},
          );
        }
      }
    });
  }
}
