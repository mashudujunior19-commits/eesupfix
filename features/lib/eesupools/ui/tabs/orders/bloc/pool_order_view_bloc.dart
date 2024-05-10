import 'package:bloc/bloc.dart';
import 'package:data_sources/eesupools/models/eesupool_order.dart';
import 'package:meta/meta.dart';
import 'package:repository/eesupools/eesupool_repo.dart';

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
        emit(
          PoolOrderViewCurrentState(current.copyWith(deliveredAt: event.now)),
        );
      }
    });
  }
}
