/// The business a person registered through Get Involved. Shown on the profile
/// while the Business profile is active.
class BusinessProfile {
  const BusinessProfile({
    required this.businessName,
    this.referralCode,
    this.registrationNumber,
    this.vatNumber,
    this.taxNumber,
    this.industryType,
    this.businessType,
    this.address,
    this.province,
  });

  final String businessName;

  /// Unique to the business; never the same as a personal referral code.
  final int? referralCode;
  final String? registrationNumber;
  final String? vatNumber;
  final String? taxNumber;
  final String? industryType;
  final String? businessType;
  final String? address;
  final String? province;

  factory BusinessProfile.fromJson(Map<String, dynamic> json) {
    return BusinessProfile(
      businessName: (json['business_name'] as String?) ?? '',
      referralCode: json['referral_code'] as int?,
      registrationNumber: json['registration_number'] as String?,
      vatNumber: json['vat_number'] as String?,
      taxNumber: json['tax_number'] as String?,
      industryType: json['industry_type'] as String?,
      businessType: json['business_type'] as String?,
      address: json['address'] as String?,
      province: json['province'] as String?,
    );
  }
}
