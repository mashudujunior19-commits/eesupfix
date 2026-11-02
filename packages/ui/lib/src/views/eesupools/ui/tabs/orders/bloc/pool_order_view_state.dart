part of 'pool_order_view_bloc.dart';

@immutable
sealed class PoolOrderViewState {}

final class PoolOrderViewLoading extends PoolOrderViewState {}

final class PoolOrderViewCurrentState extends PoolOrderViewState {
  final EESUpoolOrder pooOrder;

  /// Set when the last change was refused (e.g. closing below the minimum);
  /// [pooOrder] is then the unchanged order.
  final String? error;
  PoolOrderViewCurrentState(this.pooOrder, {this.error});
}

final class PoolOrderViewError extends PoolOrderViewState {
  final String errorMessage;
  PoolOrderViewError(this.errorMessage);
}

final class EESUpoolSettingsLoaded extends PoolOrderViewState {
  final EESUpoolSettings settings;

  EESUpoolSettingsLoaded(this.settings);
}

class ShowPopup extends PoolOrderViewState {
  final String message;
  ShowPopup(this.message);
}

class OrderCancelled extends PoolOrderViewState {}
