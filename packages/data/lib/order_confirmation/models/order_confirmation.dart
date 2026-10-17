// What the member can confirm on a delivered KasiPool order.

enum ConfirmationRemedy {
  refund,
  backorder;

  String get value => name;

  static ConfirmationRemedy? fromJson(String? v) {
    switch (v) {
      case 'refund':
        return ConfirmationRemedy.refund;
      case 'backorder':
        return ConfirmationRemedy.backorder;
    }
    return null;
  }
}

enum BackorderWhen {
  nextRoute,
  nextOrder;

  String get value => this == nextRoute ? 'next_route' : 'next_order';

  static BackorderWhen? fromJson(String? v) {
    switch (v) {
      case 'next_route':
        return BackorderWhen.nextRoute;
      case 'next_order':
        return BackorderWhen.nextOrder;
    }
    return null;
  }
}

class ConfirmationLine {
  const ConfirmationLine({
    required this.productId,
    required this.name,
    this.size,
    this.brand,
    this.imageUrl,
    required this.orderedQty,
    this.receivedQty,
    this.remedy,
    this.backorderWhen,
  });

  final int productId;
  final String name;
  final String? size;
  final String? brand;
  final String? imageUrl;
  final int orderedQty;

  /// Only set once the order has been confirmed.
  final int? receivedQty;
  final ConfirmationRemedy? remedy;
  final BackorderWhen? backorderWhen;

  factory ConfirmationLine.fromJson(Map<String, dynamic> json) {
    return ConfirmationLine(
      productId: (json['product_id'] as num).toInt(),
      name: (json['name'] as String?) ?? 'Product',
      size: json['size'] as String?,
      brand: json['brand'] as String?,
      imageUrl: json['image_url'] as String?,
      orderedQty: (json['ordered_qty'] as num?)?.toInt() ?? 0,
      receivedQty: (json['received_qty'] as num?)?.toInt(),
      remedy: ConfirmationRemedy.fromJson(json['remedy'] as String?),
      backorderWhen: BackorderWhen.fromJson(json['backorder_when'] as String?),
    );
  }
}

class OrderConfirmation {
  const OrderConfirmation({
    required this.orderId,
    required this.canConfirm,
    this.reason,
    this.confirmedAt,
    this.poolReceivedAt,
    this.lines = const [],
  });

  final int orderId;
  final bool canConfirm;
  final String? reason;
  final DateTime? confirmedAt;
  final DateTime? poolReceivedAt;
  final List<ConfirmationLine> lines;

  bool get isConfirmed => confirmedAt != null;

  factory OrderConfirmation.fromJson(Map<String, dynamic> json) {
    DateTime? ts(dynamic v) => v == null ? null : DateTime.tryParse('$v');
    return OrderConfirmation(
      orderId: (json['order_id'] as num).toInt(),
      canConfirm: (json['can_confirm'] as bool?) ?? false,
      reason: json['reason'] as String?,
      confirmedAt: ts(json['confirmed_at']),
      poolReceivedAt: ts(json['pool_received_at']),
      lines: ((json['lines'] as List?) ?? const [])
          .map((e) => ConfirmationLine.fromJson(
              Map<String, dynamic>.from(e as Map)))
          .toList(),
    );
  }
}

/// One line as sent to confirm_member_order.
class ConfirmationLineInput {
  const ConfirmationLineInput({
    required this.productId,
    required this.receivedQty,
    this.remedy,
    this.backorderWhen,
    this.photoUrl,
    this.note,
  });

  final int productId;
  final int receivedQty;
  final ConfirmationRemedy? remedy;
  final BackorderWhen? backorderWhen;
  final String? photoUrl;
  final String? note;

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'received_qty': receivedQty,
        'remedy': remedy?.value,
        'backorder_when': remedy == ConfirmationRemedy.backorder
            ? backorderWhen?.value
            : null,
        'photo_url': photoUrl,
        'note': note,
      };
}

class ConfirmResult {
  const ConfirmResult({
    required this.ok,
    required this.orderId,
    this.status,
    this.confirmedAt,
    this.alreadyConfirmed = false,
    this.orderedTotal = 0,
    this.receivedTotal = 0,
    this.queueItems = 0,
  });

  final bool ok;
  final int orderId;
  final String? status;
  final DateTime? confirmedAt;
  final bool alreadyConfirmed;
  final int orderedTotal;
  final int receivedTotal;
  final int queueItems;

  factory ConfirmResult.fromJson(Map<String, dynamic> json) {
    return ConfirmResult(
      ok: (json['ok'] as bool?) ?? false,
      orderId: (json['order_id'] as num?)?.toInt() ?? 0,
      status: json['status'] as String?,
      confirmedAt: json['confirmed_at'] == null
          ? null
          : DateTime.tryParse('${json['confirmed_at']}'),
      alreadyConfirmed: (json['already_confirmed'] as bool?) ?? false,
      orderedTotal: (json['ordered_total'] as num?)?.toInt() ?? 0,
      receivedTotal: (json['received_total'] as num?)?.toInt() ?? 0,
      queueItems: (json['queue_items'] as num?)?.toInt() ?? 0,
    );
  }
}
