part of 'order_receivers_bloc.dart';

@immutable
sealed class OrderReceiversEvent {}

final class OrderReceiversFetched extends OrderReceiversEvent {
  final List<String> receivers;
  final Map<String, ReceiverRole> initialRoles;
  OrderReceiversFetched(this.receivers, [this.initialRoles = const {}]);
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

/// Assigns (or clears, if [role] is null) the role a bulk receiver plays in
/// fulfilling the order (Receiver / Packer / Distributor), so the pool
/// admin can see who does what.
final class OrderReceiverRoleAssigned extends OrderReceiversEvent {
  final int orderId;
  final String memberId;
  final ReceiverRole? role;
  OrderReceiverRoleAssigned(this.orderId, this.memberId, this.role);
}
