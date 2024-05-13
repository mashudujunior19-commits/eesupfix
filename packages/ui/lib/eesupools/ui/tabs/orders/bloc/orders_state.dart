part of 'orders_bloc.dart';

@immutable
sealed class OrdersState {}

final class OrdersLoading extends OrdersState {}

final class OrdersLoaded extends OrdersState {
  final EESUpoolOrder? openOrder;
  final List<EESUpoolOrder> orders;
  OrdersLoaded(this.openOrder,this.orders);
}

final class OrdersError extends OrdersState {
  final EESUpException error;
  OrdersError(this.error);
}
