import 'package:bloc/bloc.dart';
import 'package:data_sources/orders/models/order.dart';
import 'package:meta/meta.dart';
import 'package:repository/orders/order_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderRepository _orderRepo;
  OrdersBloc(this._orderRepo) : super(OrdersLoading()) {
    on<OrdersFetched>((event, emit) async {
      // emit(OrdersLoading());
      ///get the orders stream
      final stream = _orderRepo.streamCustomerOrders(
        event.initStatuses,
        event.initLimit,
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
  }
}
