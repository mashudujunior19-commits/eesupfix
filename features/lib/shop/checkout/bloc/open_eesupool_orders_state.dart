part of 'open_eesupool_orders_bloc.dart';

@immutable
sealed class OpenEesUpoolOrdersState {}

final class OpenEESUpoolOrdersLoading extends OpenEesUpoolOrdersState {}

final class OpenEESUpoolOrdersError extends OpenEesUpoolOrdersState {
  final EESUpException exception;
  OpenEESUpoolOrdersError(this.exception);
}

final class OpenEESUpoolOrdersLoaded extends OpenEesUpoolOrdersState {
  final List<EESUpoolOrder> openOrders;
  OpenEESUpoolOrdersLoaded(this.openOrders);
}
