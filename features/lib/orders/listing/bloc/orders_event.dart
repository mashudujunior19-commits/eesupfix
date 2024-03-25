part of 'orders_bloc.dart';

@immutable
sealed class OrdersEvent {}

final class OrdersFetched extends OrdersEvent {
  final List<OrderStatus> initStatuses;
  final int initLimit;
  OrdersFetched(this.initStatuses, this.initLimit);
}


