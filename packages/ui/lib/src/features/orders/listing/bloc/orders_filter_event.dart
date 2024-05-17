part of 'orders_filter_bloc.dart';

@immutable
sealed class OrdersFilterEvent {}

final class OrdersFiltersChanged extends OrdersFilterEvent {
  final List<OrderStatus> statuses;
  final int limit;
  OrdersFiltersChanged(this.statuses, this.limit);
}
