part of 'pool_order_view_bloc.dart';

@immutable
sealed class PoolOrderViewState {}

final class PoolOrderViewLoading extends PoolOrderViewState {}

final class PoolOrderViewCurrentState extends PoolOrderViewState {
  final EESUpoolOrder pooOrder;
  PoolOrderViewCurrentState(this.pooOrder);
}
