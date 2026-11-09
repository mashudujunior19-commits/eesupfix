import 'package:data/get_involved/models/get_involved_submission_type.dart';

class GetInvolvedSubmission {
  final String? id;
  final String? userId;
  final DateTime? createdAt;
  final GetInvolvedSubmissionType submissionType;
  final String organisationName;
  final String industryType;

  /// Business submissions only: the business type within [industryType]
  /// (one of TOWRIS's 8 commercial verticals).
  final String? businessType;
  final String? address;
  final String? province;
  final String? socialDevelopmentNumber;

  /// Typed company details (CIPC registration number, tax and VAT numbers).
  final String? registrationNumber;
  final String? vatNumber;
  final String? taxNumber;
  final bool isKasilift;
  final String? aboutUs;
  final String? status;

  /// Why a reviewer rejected it. Read-only: never sent back to the server.
  final String? decisionReason;

  const GetInvolvedSubmission({
    this.id,
    this.userId,
    this.createdAt,
    required this.submissionType,
    required this.organisationName,
    required this.industryType,
    this.businessType,
    this.address,
    this.province,
    this.socialDevelopmentNumber,
    this.registrationNumber,
    this.vatNumber,
    this.taxNumber,
    this.isKasilift = false,
    this.aboutUs,
    this.status,
    this.decisionReason,
  });

  GetInvolvedSubmission copyWith({
    String? id,
    String? userId,
    DateTime? createdAt,
    GetInvolvedSubmissionType? submissionType,
    String? organisationName,
    String? industryType,
    String? businessType,
    String? address,
    String? province,
    String? socialDevelopmentNumber,
    String? registrationNumber,
    String? vatNumber,
    String? taxNumber,
    bool? isKasilift,
    String? aboutUs,
    String? status,
    String? decisionReason,
  }) {
    return GetInvolvedSubmission(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      submissionType: submissionType ?? this.submissionType,
      organisationName: organisationName ?? this.organisationName,
      industryType: industryType ?? this.industryType,
      businessType: businessType ?? this.businessType,
      address: address ?? this.address,
      province: province ?? this.province,
      socialDevelopmentNumber:
          socialDevelopmentNumber ?? this.socialDevelopmentNumber,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      vatNumber: vatNumber ?? this.vatNumber,
      taxNumber: taxNumber ?? this.taxNumber,
      isKasilift: isKasilift ?? this.isKasilift,
      aboutUs: aboutUs ?? this.aboutUs,
      status: status ?? this.status,
      decisionReason: decisionReason ?? this.decisionReason,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (userId != null) 'user_id': userId,
      'submission_type': submissionType.toString(),
      'organisation_name': organisationName,
      'industry_type': industryType,
      if (businessType != null) 'business_type': businessType,
      if (address != null) 'address': address,
      if (province != null) 'province': province,
      if (socialDevelopmentNumber != null)
        'social_development_number': socialDevelopmentNumber,
      if (registrationNumber != null) 'registration_number': registrationNumber,
      if (vatNumber != null) 'vat_number': vatNumber,
      if (taxNumber != null) 'tax_number': taxNumber,
      'is_kasilift': isKasilift,
      if (aboutUs != null) 'about_us': aboutUs,
    };
  }

  factory GetInvolvedSubmission.fromJson(Map<String, dynamic> json) {
    return GetInvolvedSubmission(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      submissionType: GetInvolvedSubmissionType.fromString(
        json['submission_type'] as String,
      ),
      organisationName: json['organisation_name'] as String,
      industryType: json['industry_type'] as String,
      businessType: json['business_type'] as String?,
      address: json['address'] as String?,
      province: json['province'] as String?,
      socialDevelopmentNumber: json['social_development_number'] as String?,
      registrationNumber: json['registration_number'] as String?,
      vatNumber: json['vat_number'] as String?,
      taxNumber: json['tax_number'] as String?,
      isKasilift: json['is_kasilift'] as bool? ?? false,
      aboutUs: json['about_us'] as String?,
      status: json['status'] as String?,
      decisionReason: json['decision_reason'] as String?,
    );
  }
}
