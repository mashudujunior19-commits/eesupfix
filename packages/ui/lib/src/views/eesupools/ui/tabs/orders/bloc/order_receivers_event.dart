part of 'order_receivers_bloc.dart';

@immutable
sealed class OrderReceiversEvent {}

final class OrderReceiversFetched extends OrderReceiversEvent {
  final List<String> receivers;
  final Map<String, ReceiverRole> initialRoles;
  OrderReceiversFetched(this.receivers, [this.initialRoles = const {}]);
}

/// A change to the receivers list. Changes are applied (and
/// saved) one at a time, in the order the admin made them.
sealed class OrderReceiverChange extends OrderReceiversEvent {}

final class OrderReceiverRemoved extends OrderReceiverChange {
  final int orderId;
  final EESUpoolMember member;
  OrderReceiverRemoved(this.orderId, this.member);
}

final class OrderReceiverAdded extends OrderReceiverChange {
  final int orderId;
  final EESUpoolMember member;
  OrderReceiverAdded(this.orderId, this.member);
}
