import 'package:bloc/bloc.dart';
import 'package:data_sources/orders/models/order.dart';
import 'package:either_dart/either.dart';
import 'package:meta/meta.dart';

part 'order_tracking_event.dart';
part 'order_tracking_state.dart';

class OrderTrackingBloc extends Bloc<OrderTrackingEvent, OrderTrackingState> {
  OrderTrackingBloc() : super(OrderTrackingInitial()) {
    on<OrderLoaded>((event, emit) async {
      emit(OrderTrackingInitial());
      event.params.fold((left) {}, (right) {
        emit(CurrentOrderTracking(right));
      });
    });
  }
}
