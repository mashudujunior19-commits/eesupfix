import 'package:bloc/bloc.dart';
import 'package:data_sources/eesupools/models/eesupool_order.dart';
import 'package:meta/meta.dart';
import 'package:repository/eesupools/eesupool_orders_repo.dart';
import 'package:repository/eesupools/eesupool_repo.dart';
import 'package:repository/utils/eesup_exception.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final EESUpoolRepository _poolRepo;
  OrdersBloc(this._poolRepo) : super(OrdersLoading()) {
    on<PoolOrdersFetched>((event, emit) async {
      emit(OrdersLoading());
      late final List<EESUpoolOrder> orders;
      EESUpoolOrder? openOrder;
      final openRes = await _poolRepo.fetchOpenOrder(event.poolId);
      final ordersRes = await _poolRepo.fetchEESUpoolOrders(
        event.poolId,
        event.limit,
      );
      ordersRes.fold((l) {
        emit(OrdersError(l));
      }, (r) {
        orders = r;
      });
      openRes.fold((left) {
        emit(OrdersError(left));
      }, (right) {
        openOrder = right;
      });
      emit(OrdersLoaded(openOrder, orders));
    });
  }
}
