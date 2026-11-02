/// One product on the "Order Received" checklist of a bulk order receiver.
/// No prices. The received quantity can only be lowered from [orderedQty].
class ReceiptItem {
  const ReceiptItem({
    required this.productId,
    required this.name,
    required this.size,
    required this.imageUrl,
    required this.orderedQty,
    required this.receivedQty,
    required this.isFaulty,
    required this.faultComment,
    required this.faultPhotoUrl,
  });

  final int productId;
  final String name;
  final String? size;
  final String? imageUrl;
  final int orderedQty;
  final int receivedQty;
  final bool isFaulty;
  final String? faultComment;
  final String? faultPhotoUrl;

  ReceiptItem copyWith({
    int? receivedQty,
    bool? isFaulty,
    String? faultComment,
    String? faultPhotoUrl,
  }) =>
      ReceiptItem(
        productId: productId,
        name: name,
        size: size,
        imageUrl: imageUrl,
        orderedQty: orderedQty,
        receivedQty: receivedQty ?? this.receivedQty,
        isFaulty: isFaulty ?? this.isFaulty,
        faultComment: faultComment ?? this.faultComment,
        faultPhotoUrl: faultPhotoUrl ?? this.faultPhotoUrl,
      );

  factory ReceiptItem.fromJson(Map<String, dynamic> json) {
    final ordered = (json['ordered_qty'] as num?)?.toInt() ?? 0;
    return ReceiptItem(
      productId: (json['product_id'] as num).toInt(),
      name: (json['name'] as String?) ?? 'Product',
      size: json['size'] as String?,
      imageUrl: json['image_url'] as String?,
      orderedQty: ordered,
      receivedQty: (json['received_qty'] as num?)?.toInt() ?? ordered,
      isFaulty: (json['is_faulty'] as bool?) ?? false,
      faultComment: json['fault_comment'] as String?,
      faultPhotoUrl: json['fault_photo_url'] as String?,
    );
  }
}

/// Where the signed-in member stands on a bulk order's receipt.
class ReceiptState {
  const ReceiptState({
    required this.isReceiver,
    required this.isAdmin,
    required this.isDispatched,
    required this.confirmedAt,
  });

  final bool isReceiver;
  final bool isAdmin;

  /// The warehouse has dispatched the order: the "Order Received" screen only
  /// opens from here.
  final bool isDispatched;
  final DateTime? confirmedAt;

  bool get isConfirmed => confirmedAt != null;
  bool get canConfirm => isReceiver && isDispatched && !isConfirmed;

  factory ReceiptState.fromJson(Map<String, dynamic> json) => ReceiptState(
        isReceiver: (json['is_receiver'] as bool?) ?? false,
        isAdmin: (json['is_admin'] as bool?) ?? false,
        isDispatched: (json['is_dispatched'] as bool?) ?? false,
        confirmedAt: json['confirmed_at'] == null
            ? null
            : DateTime.tryParse('${json['confirmed_at']}')?.toLocal(),
      );
}

/// Expected delivery date and PIN: only the KasiPool admin and the bulk
/// receivers can load this.
class DeliveryInfo {
  const DeliveryInfo({required this.expectedDate, required this.pin});

  final DateTime? expectedDate;
  final int? pin;

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) => DeliveryInfo(
        expectedDate: json['expected_date'] == null
            ? null
            : DateTime.tryParse('${json['expected_date']}')?.toLocal(),
        pin: (json['secret_pin'] as num?)?.toInt(),
      );
}
