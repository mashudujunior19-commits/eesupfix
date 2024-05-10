part of 'order_tracking_bloc.dart';

@immutable
sealed class OrderTrackingEvent {}

final class OrderLoaded extends OrderTrackingEvent {
  final Either<int, Order> params;
  OrderLoaded(this.params);
}

final class OrderStatusUpdated extends OrderTrackingEvent {
  final Order updated;
  OrderStatusUpdated(this.updated);
}
