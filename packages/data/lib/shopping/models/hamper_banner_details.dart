/// One Home banner entry. When [hamperId] is set the entry is a hamper and
/// tapping it opens that hamper; otherwise it is a plain image.
///
/// Cost and profit figures are no longer part of this model: the database
/// function that fills it does not return them.
class HamperBannerDetail {
  final String? hamperId;
  final String? code;
  final String gif1;
  final String gif2;
  final String? type;
  final double value;
  final double saving;
  final String baseImage;
  final String? expiryDate;
  final int orderNumber;

  HamperBannerDetail({
    this.hamperId,
    this.code,
    this.gif1 = '',
    this.gif2 = '',
    this.type,
    this.value = 0.0,
    this.saving = 0.0,
    this.baseImage = '',
    this.expiryDate,
    required this.orderNumber,
  });

  // Factory constructor to handle null values
  factory HamperBannerDetail.fromJson(Map<String, dynamic> json) {
    return HamperBannerDetail(
      hamperId: json['hamper_id'] as String?,
      code: json['code'] as String?,
      gif1: json['gif1'] as String? ?? '',
      gif2: json['gif2'] as String? ?? '',
      type: json['type'] as String?,
      value: _nullableDouble(json['value']),
      saving: _nullableDouble(json['saving']),
      baseImage: json['base_image'] as String? ?? '',
      expiryDate: json['expiry_date'] as String?,
      orderNumber: (json['order_number'] as num?)?.toInt() ?? 0,
    );
  }

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'hamper_id': hamperId,
      'code': code,
      'gif1': gif1,
      'gif2': gif2,
      'type': type,
      'value': value,
      'saving': saving,
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
