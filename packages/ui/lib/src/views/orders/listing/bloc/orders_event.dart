part of 'orders_bloc.dart';

@immutable
sealed class OrdersEvent {}

final class OrdersFetched extends OrdersEvent {
  final List<OrderStatus> initStatuses;
  final int initLimit;
  OrdersFetched(this.initStatuses, this.initLimit);
}

class OrderProductsFetched extends OrdersEvent {
  final int orderId;

  OrderProductsFetched(this.orderId);
}
