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

final class PoolOrderUpdated extends PoolOrderViewEvent {
  final EESUpoolOrder order;
  PoolOrderUpdated(this.order);
}

class FetchEESUpoolSettings extends PoolOrderViewEvent {
  FetchEESUpoolSettings();
}

class ExtendOrderDeadline extends PoolOrderViewEvent {
  final EESUpoolOrder order;
  ExtendOrderDeadline(this.order);
}

class CancelOrder extends PoolOrderViewEvent {
  final int orderId;
  final int poolId;
  CancelOrder(this.orderId, this.poolId);
}
