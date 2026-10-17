/// Timestamps of the Centre steps for one KasiPool order (no PIN, no secrets).
class PoolOrderProgress {
  const PoolOrderProgress({
    required this.eesupoolOrderId,
    this.packedAt,
    this.readyAt,
    this.departedAt,
    this.receivedAt,
  });

  final int eesupoolOrderId;
  final DateTime? packedAt;
  final DateTime? readyAt;
  final DateTime? departedAt;
  final DateTime? receivedAt;

  bool get isEmpty =>
      packedAt == null &&
      readyAt == null &&
      departedAt == null &&
      receivedAt == null;

  static DateTime? _ts(dynamic v) {
    if (v == null) return null;
    return DateTime.tryParse(v.toString())?.toLocal();
  }

  /// Defensive: anything that is not a map yields an empty progress.
  factory PoolOrderProgress.fromJson(dynamic json, {required int fallbackId}) {
    if (json is! Map) return PoolOrderProgress(eesupoolOrderId: fallbackId);
    final id = json['eesupool_order_id'];
    return PoolOrderProgress(
      eesupoolOrderId: id is num ? id.toInt() : fallbackId,
      packedAt: _ts(json['packed_at']),
      readyAt: _ts(json['ready_at']),
      departedAt: _ts(json['departed_at']),
      receivedAt: _ts(json['received_at']),
    );
  }
}
