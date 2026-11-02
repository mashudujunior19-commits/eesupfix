/// Another KasiPool's open order that is also below the minimum and can be
/// consolidated with (see `communities.get_consolidation_candidates`).
class ConsolidationCandidate {
  const ConsolidationCandidate({
    required this.orderId,
    required this.poolName,
    required this.currentAmount,
    required this.closesAt,
  });

  final int orderId;
  final String poolName;
  final double currentAmount;
  final DateTime closesAt;

  factory ConsolidationCandidate.fromJson(Map<String, dynamic> json) =>
      ConsolidationCandidate(
        orderId: (json['order_id'] as num).toInt(),
        poolName: (json['pool_name'] as String?) ?? 'KasiPool',
        currentAmount: (json['current_amount'] as num?)?.toDouble() ?? 0,
        closesAt: DateTime.parse(json['closes_at'] as String),
      );
}
