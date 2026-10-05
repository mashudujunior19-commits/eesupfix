/// A KasiPool order the signed-in user has been given a role on: either a
/// role on the pool's bulk order (Receiver / Packer / Distributor) or an
/// assignment on another member's order (Packer / Collector / both).
class RoleAssignedOrder {
  const RoleAssignedOrder({
    required this.isBulk,
    required this.eesupoolId,
    required this.eesupoolName,
    required this.eesupoolOrderId,
    required this.orderId,
    required this.role,
    required this.customerName,
    required this.scheduleFor,
    required this.deliveredAt,
  });

  final bool isBulk;
  final int eesupoolId;
  final String eesupoolName;
  final int eesupoolOrderId;

  /// The member order's id; null for a bulk-order role.
  final int? orderId;
  final String role;
  final String? customerName;
  final DateTime? scheduleFor;
  final DateTime? deliveredAt;

  factory RoleAssignedOrder.fromJson(Map<String, dynamic> json) {
    return RoleAssignedOrder(
      isBulk: json['kind'] == 'bulk',
      eesupoolId: json['eesupool_id'] as int,
      eesupoolName: (json['eesupool_name'] as String?) ?? 'KasiPool',
      eesupoolOrderId: json['eesupool_order_id'] as int,
      orderId: json['order_id'] as int?,
      role: (json['role'] as String?) ?? '',
      customerName: json['customer_name'] as String?,
      scheduleFor: DateTime.tryParse(json['schedule_for'] as String? ?? ''),
      deliveredAt: DateTime.tryParse(json['delivered_at'] as String? ?? ''),
    );
  }
}
