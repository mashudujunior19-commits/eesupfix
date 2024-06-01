part of 'order_tracking_bloc.dart';

@immutable
sealed class OrderTrackingEvent {}

final class OrderLoaded extends OrderTrackingEvent {
  final int id;
  OrderLoaded(this.id);
}

final class OrderStatusUpdated extends OrderTrackingEvent {
  final Order updated;
  OrderStatusUpdated(this.updated);
}

final class OrderInvoiceGenerated extends OrderTrackingEvent {
  final Order order;
  OrderInvoiceGenerated(this.order);
}
