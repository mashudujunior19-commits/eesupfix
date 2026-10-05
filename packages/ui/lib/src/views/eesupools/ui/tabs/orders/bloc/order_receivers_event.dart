part of 'order_receivers_bloc.dart';

@immutable
sealed class OrderReceiversEvent {}

final class OrderReceiversFetched extends OrderReceiversEvent {
  final List<String> receivers;
  final Map<String, ReceiverRole> initialRoles;
  OrderReceiversFetched(this.receivers, [this.initialRoles = const {}]);
}

/// A change to the receivers list or their roles. Changes are applied (and
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

/// Assigns the role a bulk receiver plays in fulfilling the order
/// (Receiver / Packer / Distributor), so the pool admin can see who does
/// what. A receiver always has a role; there is no "no role" option.
final class OrderReceiverRoleAssigned extends OrderReceiverChange {
  final int orderId;
  final String memberId;
  final ReceiverRole role;
  OrderReceiverRoleAssigned(this.orderId, this.memberId, this.role);
}
