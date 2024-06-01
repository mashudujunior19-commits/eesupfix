part of 'member_orders_bloc.dart';

@immutable
sealed class MemberOrdersState {}

final class OrdersLoading extends MemberOrdersState {}

final class OrdersLoaded extends MemberOrdersState {
  final List<Order> orders;
  OrdersLoaded(this.orders);
}

final class OrdersError extends MemberOrdersState {
  final EESUpException exception;
  OrdersError(this.exception);
}
