part of 'orders_bloc.dart';

@immutable
sealed class OrdersEvent {}

final class PoolOrdersFetched extends OrdersEvent {
  final int poolId;
  final int limit;
  PoolOrdersFetched(this.poolId, this.limit);
}
