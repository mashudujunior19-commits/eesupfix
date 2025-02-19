class HamperBannerDetail {
  final String? code;
  final String gif1;
  final String gif2;
  final String? type;
  final double value;
  final double profit;
  final double profitPercentage;
  final List<String> userRole;
  final String baseImage;
  final String? expiryDate;
  final int orderNumber;

  HamperBannerDetail({
    this.code,
    this.gif1 = '',
    this.gif2 = '',
    this.type,
    this.value = 0.0,
    this.profit = 0.0,
    this.profitPercentage = 0.0,
    List<String>? userRole,
    this.baseImage = '',
    this.expiryDate,
    required this.orderNumber,
  }) : userRole = userRole ?? [];

  // Factory constructor to handle null values
  factory HamperBannerDetail.fromJson(Map<String, dynamic> json) {
    return HamperBannerDetail(
      code: json['code'] as String?,
      gif1: json['gif1'] as String? ?? '',
      gif2: json['gif2'] as String? ?? '',
      type: json['type'] as String?,
      value: _nullableDouble(json['value']),
      profit: _nullableDouble(json['profit']),
      profitPercentage: _nullableDouble(json['profit_percentage']),
      userRole:
          (json['user_role'] as List?)?.map((e) => e.toString()).toList() ?? [],
      baseImage: json['base_image'] as String? ?? '',
      expiryDate: json['expiry_date'] as String?,
      orderNumber: (json['order_number'] as num).toInt(),
    );
  }

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'gif1': gif1,
      'gif2': gif2,
      'type': type,
      'value': value,
      'profit': profit,
      'profit_percentage': profitPercentage,
      'user_role': userRole,
      'base_image': baseImage,
      'expiry_date': expiryDate,
      'order_number': orderNumber,
    };
  }
}

// Safely parse nullable double values
double _nullableDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString()) ?? 0.0;
}
