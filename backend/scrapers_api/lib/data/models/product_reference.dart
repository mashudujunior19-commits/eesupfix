class ScraperProduct {
  ScraperProduct({
    required this.source,
    required this.scrapeDate,
    this.barCode,
    this.kitKatRef,
    this.priceCategory,
    this.originalPrice,
    this.offerPrice,
    this.sourceCode,
    this.name,
    this.description,
    this.category,
    this.additional1,
    this.ingredients,
    this.usage,
    this.features,
    this.affiliation,
    this.promotion,
    this.url,
    this.region,
    this.brand,
    this.keyword,
  });
  String? barCode;
  String? kitKatRef;
  String source;
  String? priceCategory;
  double? originalPrice;
  String? offerPrice;
  String? sourceCode;
  String? name;
  String? description;
  String? category;
  String? additional1;
  String? ingredients;
  String? usage;
  String? features;
  String? affiliation;
  bool? promotion;
  String? url;
  String? region;
  String? brand;
  String? keyword;
  DateTime scrapeDate;

  Map<String, dynamic> toMap() {
    return {
      'bar_code': barCode?.trim(),
      'kit_kat_ref': kitKatRef?.trim(),
      'source': source,
      'scrape_date': scrapeDate.toIso8601String(),
      'price_category': priceCategory,
      'original_price': originalPrice,
      'offer_price': offerPrice ?? '',
      'source_code': sourceCode,
      'name': name,
      'description': description,
      'category': category,
      'additional1': additional1,
      'ingredients': ingredients,
      'usage': usage,
      'features': features,
      'affiliation': affiliation,
      'promotion': promotion,
      'url': url,
      'region': region,
      'brand': brand,
      'keyword': keyword,
    };
  }
}
