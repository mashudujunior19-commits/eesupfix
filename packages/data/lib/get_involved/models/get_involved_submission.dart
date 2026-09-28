import 'package:data/get_involved/models/get_involved_submission_type.dart';

class GetInvolvedSubmission {
  final String? id;
  final String? userId;
  final DateTime? createdAt;
  final GetInvolvedSubmissionType submissionType;
  final String organisationName;
  final String industryType;
  final String? address;
  final String? province;
  final String? socialDevelopmentNumber;
  final bool isKasilift;
  final String? aboutUs;
  final String? status;

  const GetInvolvedSubmission({
    this.id,
    this.userId,
    this.createdAt,
    required this.submissionType,
    required this.organisationName,
    required this.industryType,
    this.address,
    this.province,
    this.socialDevelopmentNumber,
    this.isKasilift = false,
    this.aboutUs,
    this.status,
  });

  GetInvolvedSubmission copyWith({
    String? id,
    String? userId,
    DateTime? createdAt,
    GetInvolvedSubmissionType? submissionType,
    String? organisationName,
    String? industryType,
    String? address,
    String? province,
    String? socialDevelopmentNumber,
    bool? isKasilift,
    String? aboutUs,
    String? status,
  }) {
    return GetInvolvedSubmission(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      submissionType: submissionType ?? this.submissionType,
      organisationName: organisationName ?? this.organisationName,
      industryType: industryType ?? this.industryType,
      address: address ?? this.address,
      province: province ?? this.province,
      socialDevelopmentNumber:
          socialDevelopmentNumber ?? this.socialDevelopmentNumber,
      isKasilift: isKasilift ?? this.isKasilift,
      aboutUs: aboutUs ?? this.aboutUs,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (userId != null) 'user_id': userId,
      'submission_type': submissionType.toString(),
      'organisation_name': organisationName,
      'industry_type': industryType,
      if (address != null) 'address': address,
      if (province != null) 'province': province,
      if (socialDevelopmentNumber != null)
        'social_development_number': socialDevelopmentNumber,
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
      address: json['address'] as String?,
      province: json['province'] as String?,
      socialDevelopmentNumber: json['social_development_number'] as String?,
      isKasilift: json['is_kasilift'] as bool? ?? false,
      aboutUs: json['about_us'] as String?,
      status: json['status'] as String?,
    );
  }
}
