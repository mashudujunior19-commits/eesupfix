class CheckersProduct {
  CheckersProduct({
    required this.productTitle,
    required this.originalPrice,
    required this.offerPrice,
    required this.description,
    required this.productSpecs,
    required this.brand,
    required this.barcode,
    required this.category,
    required this.keyword,
  });

  factory CheckersProduct.fromJson(Map<String, dynamic> json) {
    return CheckersProduct(
      productTitle: json['product_title']?.toString(),
      originalPrice: json['original_price']?.toString(),
      offerPrice: json['offer_price']?.toString(),
      description: json['description']?.toString(),
      productSpecs: json['product_specs']?.toString(),
      brand: json['brand']?.toString(),
      barcode: json['barcode']?.toString(),
      category: json['category']?.toString(),
      keyword: json['keyword']?.toString(),
    );
  }
  String? productTitle;
  String? originalPrice;
  String? offerPrice;
  String? description;
  String? productSpecs;
  String? brand;
  String? barcode;
  String? category;
  String? keyword;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['product_title'] = productTitle;
    data['original_price'] = originalPrice;
    data['offer_price'] = offerPrice;
    data['description'] = description;
    data['product_specs'] = productSpecs;
    data['brand'] = brand;
    data['barcode'] = barcode;
    data['category'] = category;
    data['keyword'] = keyword;
    return data;
  }
}
