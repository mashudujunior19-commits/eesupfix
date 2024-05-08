import 'package:bloc/bloc.dart';
import 'package:data_sources/eesupools/models/eesupool_member.dart';
import 'package:meta/meta.dart';
import 'package:repository/eesupools/eesupool_repo.dart';
import 'package:repository/utils/eesup_exception.dart';

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
        emit(OrderReceiversLoaded(right));
      });
    });
  }
}
