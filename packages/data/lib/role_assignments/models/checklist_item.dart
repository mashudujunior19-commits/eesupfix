/// One product on a role holder's checklist. Deliberately has no price:
/// people with a role on an order see what was bought, not what it cost.
class ChecklistItem {
  const ChecklistItem({
    required this.productId,
    required this.name,
    required this.size,
    required this.imageUrl,
    required this.category,
    required this.quantity,
    required this.isChecked,
  });

  final int productId;
  final String name;
  final String? size;
  final String? imageUrl;
  final String? category;
  final int quantity;
  final bool isChecked;

  ChecklistItem copyWith({bool? isChecked}) => ChecklistItem(
        productId: productId,
        name: name,
        size: size,
        imageUrl: imageUrl,
        category: category,
        quantity: quantity,
        isChecked: isChecked ?? this.isChecked,
      );

  factory ChecklistItem.fromJson(Map<String, dynamic> json) {
    return ChecklistItem(
      productId: json['product_id'] as int,
      name: json['name'] as String,
      size: json['size'] as String?,
      imageUrl: json['image_url'] as String?,
      category: json['category'] as String?,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      isChecked: (json['is_checked'] as bool?) ?? false,
    );
  }
}
