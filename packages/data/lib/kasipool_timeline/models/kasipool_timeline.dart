/// The synchronised KasiPool order timeline returned by
/// `communities.get_pool_order_timeline` (the same data the admin app shows).
class KasiPoolTimeline {
  const KasiPoolTimeline({
    required this.eesupoolOrderId,
    required this.eesupoolName,
    required this.status,
    required this.stage,
    required this.stageLabel,
    required this.isAdmin,
    required this.events,
    required this.orders,
    this.deliveredAt,
    this.closesAt,
  });

  final int eesupoolOrderId;
  final String eesupoolName;
  final String status;
  final String stage;
  final String stageLabel;

  /// App admin or admin of this KasiPool: sees every member order with names.
  final bool isAdmin;
  final DateTime? deliveredAt;
  final DateTime? closesAt;
  final List<KasiPoolTimelineEvent> events;
  final List<KasiPoolTimelineOrder> orders;

  bool get isCompleted => stage == 'pool_order_completed';

  int get collectedCount => orders.where((o) => o.status == 'Collected').length;
  int get activeCount => orders.where((o) => o.status != 'Cancelled').length;

  factory KasiPoolTimeline.fromJson(Map<String, dynamic> json) {
    final pool = Map<String, dynamic>.from(json['pool_order'] as Map? ?? {});
    return KasiPoolTimeline(
      eesupoolOrderId: _int(pool['id']),
      eesupoolName: (pool['eesupool_name'] ?? '') as String,
      status: (pool['status'] ?? '') as String,
      deliveredAt: _date(pool['delivered_at']),
      closesAt: _date(pool['closes_at']),
      stage: (json['stage'] ?? 'open') as String,
      stageLabel: (json['stage_label'] ?? '') as String,
      isAdmin: json['is_admin'] == true,
      events: ((json['events'] as List?) ?? [])
          .map((e) =>
              KasiPoolTimelineEvent.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      orders: ((json['orders'] as List?) ?? [])
          .map((e) =>
              KasiPoolTimelineOrder.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }
}

class KasiPoolTimelineEvent {
  const KasiPoolTimelineEvent({
    required this.id,
    required this.stage,
    required this.label,
    required this.occurredAt,
    this.orderId,
    this.actorName,
    this.note,
    this.mine = false,
  });

  final int id;

  /// order_placed, pool_order_closed, processed, delivered, roles_assigned,
  /// packing_checklist_completed, pin_issued, collected, order_cancelled,
  /// pool_order_completed.
  final String stage;
  final String label;
  final DateTime occurredAt;

  /// Null for steps of the whole KasiPool order.
  final int? orderId;

  /// Who did it, when relevant.
  final String? actorName;
  final String? note;

  /// The step belongs to an order the signed-in user placed.
  final bool mine;

  factory KasiPoolTimelineEvent.fromJson(Map<String, dynamic> json) {
    return KasiPoolTimelineEvent(
      id: _int(json['id']),
      stage: (json['stage'] ?? '') as String,
      label: (json['label'] ?? '') as String,
      occurredAt: _date(json['occurred_at']) ?? DateTime.now(),
      orderId: json['order_id'] == null ? null : _int(json['order_id']),
      actorName: json['actor_name'] as String?,
      note: json['note'] as String?,
      mine: json['mine'] == true,
    );
  }
}

class KasiPoolTimelineOrder {
  const KasiPoolTimelineOrder({
    required this.orderId,
    required this.customerName,
    required this.status,
    this.placedAt,
    this.collectedAt,
    this.roles,
    this.checklistCompletedAt,
    this.pinIssuedAt,
    this.collectedBy,
    this.mine = false,
  });

  final int orderId;
  final String customerName;

  /// Placed, Packaged, Ready, Collected or Cancelled.
  final String status;
  final DateTime? placedAt;
  final DateTime? collectedAt;
  final String? roles;
  final DateTime? checklistCompletedAt;
  final DateTime? pinIssuedAt;
  final String? collectedBy;
  final bool mine;

  factory KasiPoolTimelineOrder.fromJson(Map<String, dynamic> json) {
    return KasiPoolTimelineOrder(
      orderId: _int(json['order_id']),
      customerName: (json['customer_name'] ?? '') as String,
      status: (json['status'] ?? '') as String,
      placedAt: _date(json['placed_at']),
      collectedAt: _date(json['collected_at']),
      roles: json['roles'] as String?,
      checklistCompletedAt: _date(json['checklist_completed_at']),
      pinIssuedAt: _date(json['pin_issued_at']),
      collectedBy: json['collected_by'] as String?,
      mine: json['mine'] == true,
    );
  }
}

int _int(dynamic v) => v is num ? v.toInt() : int.tryParse('$v') ?? 0;

DateTime? _date(dynamic v) =>
    v == null ? null : DateTime.tryParse(v.toString())?.toLocal();
