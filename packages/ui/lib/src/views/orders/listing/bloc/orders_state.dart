part of 'orders_bloc.dart';

@immutable
sealed class OrdersState {}

final class OrdersLoading extends OrdersState {}

final class OrdersLoaded extends OrdersState {
  final List<Order> orders;
  OrdersLoaded(this.orders);
}

final class OrdersError extends OrdersState {
  final EESUpException exception;
  OrdersError(this.exception);
}

class OrderProductsLoaded extends OrdersState {
  final List<OrderProduct> orderProducts;
  OrderProductsLoaded(this.orderProducts);
}

class OrderProductsError extends OrdersState {
  final EESUpException exception;
  OrderProductsError(this.exception);
}
