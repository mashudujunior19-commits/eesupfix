class MakroProduct {
  MakroProduct({
    required this.productName,
    required this.originalPrice,
    required this.gtin,
    required this.sku,
    required this.stockStatus,
    required this.brand,
    required this.affiliation,
    required this.categories,
    required this.promotion,
    required this.productAndPackaging,
    required this.productPageUrl,
    required this.keyword,
    required this.store,
    this.offerPrice,
  });

  factory MakroProduct.fromJson(Map<String, dynamic> json) {
    return MakroProduct(
      productName: json['product_name']?.toString(),
      originalPrice: json['original_price']?.toString(),
      offerPrice: json['offer_price']?.toString(),
      gtin: json['gtin']?.toString(),
      sku: json['sku']?.toString(),
      stockStatus: json['stock_status']?.toString(),
      brand: json['brand']?.toString(),
      affiliation: json['affiliation']?.toString(),
      categories: json['categories']?.toString(),
      promotion: json['promotion'] as bool?,
      productAndPackaging: json['product_and_packaging']?.toString(),
      productPageUrl: json['product_page_url']?.toString(),
      keyword: json['keyword']?.toString(),
      store: json['store']?.toString(),
    );
  }
  String? productName;
  String? originalPrice;
  String? offerPrice;
  String? gtin;
  String? sku;
  String? stockStatus;
  String? brand;
  String? affiliation;
  String? categories;
  bool? promotion;
  String? productAndPackaging;
  String? productPageUrl;
  String? keyword;
  String? store;


  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['product_name'] = productName;
    data['original_price'] = originalPrice;
    data['offer_price'] = offerPrice;
    data['gtin'] = gtin;
    data['sku'] = sku;
    data['stock_status'] = stockStatus;
    data['brand'] = brand;
    data['affiliation'] = affiliation;
    data['categories'] = categories;
    data['promotion'] = promotion;
    data['product_and_packaging'] = productAndPackaging;
    data['product_page_url'] = productPageUrl;
    data['keyword'] = keyword;
    data['store'] = store;
    return data;
  }
}
