part of 'member_orders_bloc.dart';

@immutable
sealed class MemberOrdersState {}

final class OrdersLoading extends MemberOrdersState {}

final class OrdersLoaded extends MemberOrdersState {
  final List<Order> orders;

  /// Set when the last role assignment change couldn't be saved.
  final String? saveError;
  OrdersLoaded(this.orders, {this.saveError});
}

final class OrdersError extends MemberOrdersState {
  final EESUpException exception;
  OrdersError(this.exception);
}
