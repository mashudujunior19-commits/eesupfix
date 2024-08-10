import 'package:bloc/bloc.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:data/eesupools/repository/eesupool_orders_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:meta/meta.dart';

part 'pool_order_view_event.dart';
part 'pool_order_view_state.dart';

class PoolOrderViewBloc extends Bloc<PoolOrderViewEvent, PoolOrderViewState> {
  // ignore: unused_field
  final EESUpoolRepository _repository;
  PoolOrderViewBloc(this._repository) : super(PoolOrderViewLoading()) {
    on<PoolOrderInitialized>((event, emit) {
      emit(PoolOrderViewCurrentState(event.order));
    });

    on<PoolOrderIsReceived>((event, emit) {
      if (state is PoolOrderViewCurrentState) {
        final current = (state as PoolOrderViewCurrentState).pooOrder;
        _repository.updateOrder(current.copyWith(deliveredAt: event.now));
        emit(
          PoolOrderViewCurrentState(current.copyWith(deliveredAt: event.now)),
        );
      }
    });

    on<PoolOrderUpdated>((event, emit) {
      _repository.updateOrder(event.order);
      emit(PoolOrderViewCurrentState(event.order));
    });
  }
}
