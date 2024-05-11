import 'package:bloc/bloc.dart';
import 'package:data_sources/orders/models/order.dart';
import 'package:meta/meta.dart';
import 'package:repository/orders/order_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

part 'order_tracking_event.dart';
part 'order_tracking_state.dart';

class OrderTrackingBloc extends Bloc<OrderTrackingEvent, OrderTrackingState> {
  final OrderRepository _repository;
  OrderTrackingBloc(this._repository) : super(OrderTrackingInitial()) {
    on<OrderLoaded>((event, emit) async {
      final stream = _repository.streamOrderById(event.id);
      await emit.forEach(
        stream,
        onData: (data) {
          return data.fold((l) {
            return CurrentOrderTrackingError(l);
          }, (r) {
            return CurrentOrderTracking(r);
          });
        },
      );
    });

    on<OrderStatusUpdated>((event, emit) {
      _repository.saveStatusChanges(event.updated).then((value) {
        value.fold((left) {
          emit(CurrentOrderTrackingError(left));
        }, (right) => null);
      });
      emit(CurrentOrderTracking(event.updated));
    });
  }
}
