part of 'order_receivers_bloc.dart';

@immutable
sealed class OrderReceiversEvent {}

final class OrderReceiversFetched extends OrderReceiversEvent {
  final List<String> receivers;
  OrderReceiversFetched(this.receivers);
}

final class OrderReceiverRemoved extends OrderReceiversEvent {
  final int orderId;
  final EESUpoolMember member;
  OrderReceiverRemoved(this.orderId, this.member);
}

final class OrderReceiverAdded extends OrderReceiversEvent {
  final int orderId;
  final EESUpoolMember member;
  OrderReceiverAdded(this.orderId, this.member);
}
