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
      final results = await _poolRepo.fetchEESUpoolOrders(
        event.poolId,
        event.limit,
      );

      results.fold((l) {}, (r) {
        emit(OrdersLoaded(r));
      });
    });
  }
}
