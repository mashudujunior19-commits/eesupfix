import 'package:bloc/bloc.dart';
import 'package:data_sources/orders/models/order.dart';
import 'package:either_dart/either.dart';
import 'package:meta/meta.dart';
import 'package:repository/orders/order_repository.dart';

part 'order_tracking_event.dart';
part 'order_tracking_state.dart';

class OrderTrackingBloc extends Bloc<OrderTrackingEvent, OrderTrackingState> {
  final OrderRepository _repository;
  OrderTrackingBloc(this._repository) : super(OrderTrackingInitial()) {
    on<OrderLoaded>((event, emit) async {
      emit(OrderTrackingInitial());
      event.params.fold((left) {}, (right) {
        emit(CurrentOrderTracking(right));
      });
    });

    on<OrderStatusUpdated>((event, emit) async {
      _repository.saveStatusChanges(event.updated);
      emit(CurrentOrderTracking(event.updated));
    });
  }
}
