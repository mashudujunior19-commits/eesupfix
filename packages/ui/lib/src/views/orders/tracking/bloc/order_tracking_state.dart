part of 'order_tracking_bloc.dart';

@immutable
sealed class OrderTrackingState {}

final class OrderTrackingLoading extends OrderTrackingState {}

final class CurrentOrderTrackingError extends OrderTrackingState {
  final EESUpException error;
  CurrentOrderTrackingError(this.error);
}

final class CurrentOrderTracking extends OrderTrackingState {
  final Order order;
  CurrentOrderTracking(this.order);
}
