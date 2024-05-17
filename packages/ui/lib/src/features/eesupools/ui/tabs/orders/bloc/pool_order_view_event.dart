part of 'pool_order_view_bloc.dart';

@immutable
sealed class PoolOrderViewEvent {}

final class PoolOrderInitialized extends PoolOrderViewEvent {
  final EESUpoolOrder order;
  PoolOrderInitialized(this.order);
}

final class PoolOrderIsReceived extends PoolOrderViewEvent {
  final DateTime now;
  PoolOrderIsReceived(this.now);
}
