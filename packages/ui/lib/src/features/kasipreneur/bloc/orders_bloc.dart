import 'package:bloc/bloc.dart';
import 'package:data/orders/models/order.dart';
import 'package:data/orders/repository/order_repository.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class KasipreneurOrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderRepository _orderRepo;
  KasipreneurOrdersBloc(this._orderRepo) : super(OrdersLoading()) {
    on<OrdersFetched>((event, emit) async {
      // emit(OrdersLoading());
      ///get the orders stream
      final stream = _orderRepo.streamShopOrders(
        shopId: event.shopId,
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
  }
}
