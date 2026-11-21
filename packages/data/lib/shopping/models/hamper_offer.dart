/// A hamper as a customer sees it: what it costs, what is inside and how much
/// they save. It comes from the database function `public.get_hampers()`, which
/// never returns cost, profit or allocation figures and already hides hampers
/// that are not meant for the signed-in user.
class HamperOffer {
  const HamperOffer({
    required this.id,
    required this.code,
    required this.type,
    required this.price,
    required this.worth,
    required this.saving,
    required this.available,
    required this.items,
    this.expiryDate,
    this.imgUrl,
    this.gifUrl1,
    this.gifUrl2,
    this.productId,
    this.productName,
    this.productImageUrl,
  });

  final String id;
  final String code;
  final String type;

  /// What the customer pays (the price on the hamper's product row).
  final double price;

  /// What the items would cost bought one by one.
  final double worth;
  final double saving;

  /// False when the hamper has no product row yet, is switched off, or one of
  /// its items is inactive. Such a hamper can be viewed but not bought.
  final bool available;
  final List<HamperOfferItem> items;
  final DateTime? expiryDate;
  final String? imgUrl;
  final String? gifUrl1;
  final String? gifUrl2;

  /// The product row that goes in the cart when the hamper is bought.
  final int? productId;
  final String? productName;
  final String? productImageUrl;

  bool get canBuy => available && productId != null;

  int get itemCount => items.length;
  int get freeItemCount => items.where((i) => i.isFree).length;

  /// Quantity of each product inside the hamper, by product id.
  Map<int, int> get quantities => {for (final i in items) i.productId: i.quantity};

  /// Whole days until the hamper ends, or null when it has no end date.
  /// 0 means it ends today.
  int? daysLeft([DateTime? now]) {
    final end = expiryDate;
    if (end == null) return null;
    final today = now ?? DateTime.now();
    final from = DateTime(today.year, today.month, today.day);
    final to = DateTime(end.year, end.month, end.day);
    return to.difference(from).inDays;
  }

  factory HamperOffer.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'];
    return HamperOffer(
      id: json['id'] as String,
      code: (json['code'] as String?) ?? '',
      type: (json['type'] as String?) ?? '',
      price: _toDouble(json['value']),
      worth: _toDouble(json['worth']),
      saving: _toDouble(json['saving']),
      available: json['available'] == true,
      items: rawItems is List
          ? rawItems
              .whereType<Map>()
              .map((e) => HamperOfferItem.fromJson(Map<String, dynamic>.from(e)))
              .toList()
          : const [],
      expiryDate: json['expiry_date'] == null
          ? null
          : DateTime.tryParse(json['expiry_date'].toString()),
      imgUrl: json['img_url'] as String?,
      gifUrl1: json['hamper_gif_url1'] as String?,
      gifUrl2: json['hamper_gif_url2'] as String?,
      productId: (json['product_id'] as num?)?.toInt(),
      productName: json['product_name'] as String?,
      productImageUrl: json['product_image_url'] as String?,
    );
  }
}

class HamperOfferItem {
  const HamperOfferItem({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.isFree,
    required this.price,
    required this.isActive,
    this.imageUrl,
  });

  final int productId;
  final String name;
  final int quantity;
  final bool isFree;
  final double price;
  final bool isActive;
  final String? imageUrl;

  factory HamperOfferItem.fromJson(Map<String, dynamic> json) {
    return HamperOfferItem(
      productId: (json['product_id'] as num).toInt(),
      name: (json['name'] as String?) ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      isFree: json['is_free'] == true,
      price: _toDouble(json['price']),
      isActive: json['is_active'] != false,
      imageUrl: json['image_url'] as String?,
    );
  }
}

double _toDouble(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString()) ?? 0;
}
