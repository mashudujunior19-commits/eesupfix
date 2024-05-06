class KitKatProduct {
  KitKatProduct({
    this.productName,
    this.code,
    this.description,
    this.offer,
    this.originalPrice,
    this.keyword,
  });

  factory KitKatProduct.fromJson(Map<String, dynamic> json) {
    return KitKatProduct(
      productName: json['product_name']?.toString(),
      code: json['code']?.toString(),
      description: json['description']?.toString(),
      offer: json['offer']?.toString(),
      originalPrice: json['original_price']?.toString(),
      keyword: json['keyword']?.toString(),
    );
  }
  String? productName;
  String? code;
  String? description;
  String? offer;
  String? originalPrice;
  String? keyword;
  String? date;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['product_name'] = productName;
    data['code'] = code;
    data['description'] = description;
    data['offer'] = offer;
    data['original_price'] = originalPrice;
    data['keyword'] = keyword;
    return data;
  }
}
