/// A product a customer may put in their own hamper, from the database
/// function `public.get_hamper_builder()`. The admin sets the most of each
/// one allowed.
class HamperBuilderItem {
  const HamperBuilderItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.maxQuantity,
    this.brand,
    this.size,
    this.imageUrl,
  });

  final int productId;
  final String name;
  final double price;
  final int maxQuantity;
  final String? brand;
  final String? size;
  final String? imageUrl;

  factory HamperBuilderItem.fromJson(Map<String, dynamic> json) {
    final max = (json['max_quantity'] as num?)?.toInt() ?? 1;
    return HamperBuilderItem(
      productId: (json['product_id'] as num).toInt(),
      name: (json['name'] as String?) ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      maxQuantity: max < 1 ? 1 : max,
      brand: json['brand'] as String?,
      size: json['size'] as String?,
      imageUrl: json['image_url'] as String?,
    );
  }
}
