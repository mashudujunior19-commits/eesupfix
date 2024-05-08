import 'package:bloc/bloc.dart';
import 'package:data_sources/eesupools/models/eesupool_order.dart';
import 'package:data_sources/orders/models/order.dart';
import 'package:meta/meta.dart';
import 'package:repository/eesupools/eesupool_orders_repo.dart';
import 'package:repository/eesupools/eesupool_repo.dart';
import 'package:repository/orders/order_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

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

    on<MemberOrderAssignmentsUpdated>((event, emit) {
      if (state is OrdersLoaded) {
        List<Order> orders = [...(state as OrdersLoaded).orders];
        final index = orders.indexWhere((e) => e.id == event.orderId);
        if (index != -1) {
          final copy = orders[index].copyWith(
            assignments: event.assignments,
          );
          orders[index] = copy;
          _poolRepository.updateOrderAssignments(
              event.assignments, event.orderId);
          emit(OrdersLoaded(orders));
        }
      }
    });
  }
}
