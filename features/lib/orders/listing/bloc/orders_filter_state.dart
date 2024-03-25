part of 'orders_filter_bloc.dart';

@immutable
sealed class OrdersFilterState {}

final class OrdersFilter extends OrdersFilterState {
  final List<OrderStatus> statuses;
  final int limit;
  OrdersFilter(this.statuses, this.limit);
}
