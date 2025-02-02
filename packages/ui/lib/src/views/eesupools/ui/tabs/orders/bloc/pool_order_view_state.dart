part of 'pool_order_view_bloc.dart';

@immutable
sealed class PoolOrderViewState {}

final class PoolOrderViewLoading extends PoolOrderViewState {}

final class PoolOrderViewCurrentState extends PoolOrderViewState {
  final EESUpoolOrder pooOrder;
  PoolOrderViewCurrentState(this.pooOrder);
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
