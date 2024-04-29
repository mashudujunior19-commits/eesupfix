part of 'order_tracking_bloc.dart';

@immutable
sealed class OrderTrackingState {}

final class OrderTrackingInitial extends OrderTrackingState {}

final class CurrentOrderTracking extends OrderTrackingState {
  final Order order;
  CurrentOrderTracking(this.order);
}
