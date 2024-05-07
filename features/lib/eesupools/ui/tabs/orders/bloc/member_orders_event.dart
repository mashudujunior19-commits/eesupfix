part of 'member_orders_bloc.dart';

@immutable
sealed class MemberOrdersEvent {}

final class MemberOrdersFetched extends MemberOrdersEvent {
  final List<OrderStatus> initStatuses;
  final int initLimit;
  final int orderId;
  MemberOrdersFetched(this.initStatuses, this.initLimit, this.orderId);
}
