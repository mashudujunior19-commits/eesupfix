part of 'orders_bloc.dart';

@immutable
sealed class OrdersEvent {}

final class OrdersFetched extends OrdersEvent {
  final String shopId;
  final List<OrderStatus> initStatuses;
  final int initLimit;
  OrdersFetched(this.shopId,this.initStatuses, this.initLimit);
}
