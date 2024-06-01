import 'package:bloc/bloc.dart';
import 'package:data/eesupools/models/eesupool_order.dart';
import 'package:data/eesupools/repository/eesupool_orders_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

part 'open_eesupool_orders_event.dart';
part 'open_eesupool_orders_state.dart';

class OpenEESUpoolOrdersBloc
    extends Bloc<OpenEESUpoolOrdersEvent, OpenEesUpoolOrdersState> {
  final EESUpoolRepository _repository;
  OpenEESUpoolOrdersBloc(this._repository)
      : super(OpenEESUpoolOrdersLoading()) {
    on<OpenOrdersFetched>((event, emit) async {
      emit(OpenEESUpoolOrdersLoading());
      final results = await _repository.fetchOpenEESUpoolOrders();
      results.fold((left) {
        emit(OpenEESUpoolOrdersError(left));
      }, (right) {
        emit(OpenEESUpoolOrdersLoaded(right));
      });
    });
  }
}
