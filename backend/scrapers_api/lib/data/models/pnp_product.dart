class PnPProduct {
  PnPProduct({
    required this.productTitle,
    required this.originalPrice,
    required this.description,
    required this.barcode,
    required this.keyword,
    required this.region,
    this.offerPrice,
  });

  factory PnPProduct.fromJson(Map<String, dynamic> json) {
    return PnPProduct(
      productTitle: json['product_title']?.toString(),
      originalPrice: json['original_price']?.toString(),
      offerPrice: json['offer_price']?.toString(),
      description: json['description']?.toString(),
      barcode: json['barcode']?.toString(),
      keyword: json['keyword']?.toString(),
      region: json['region']?.toString(),
    );
  }
  String? productTitle;
  String? originalPrice;
  String? offerPrice;
  String? description;
  String? barcode;
  String? keyword;
  String? date;
  String? region;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['product_title'] = productTitle;
    data['original_price'] = originalPrice;
    data['offer_price'] = offerPrice;
    data['description'] = description;
    data['barcode'] = barcode;
    data['keyword'] = keyword;
    data['region'] = region;
    return data;
  }
}
