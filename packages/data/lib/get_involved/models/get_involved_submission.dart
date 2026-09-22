import 'package:data/get_involved/models/get_involved_submission_type.dart';

class GetInvolvedSubmission {
  final String? id;
  final String? userId;
  final DateTime? createdAt;
  final GetInvolvedSubmissionType submissionType;
  final String organisationName;
  final String industryType;
  final String? status;

  const GetInvolvedSubmission({
    this.id,
    this.userId,
    this.createdAt,
    required this.submissionType,
    required this.organisationName,
    required this.industryType,
    this.status,
  });

  GetInvolvedSubmission copyWith({
    String? id,
    String? userId,
    DateTime? createdAt,
    GetInvolvedSubmissionType? submissionType,
    String? organisationName,
    String? industryType,
    String? status,
  }) {
    return GetInvolvedSubmission(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      submissionType: submissionType ?? this.submissionType,
      organisationName: organisationName ?? this.organisationName,
      industryType: industryType ?? this.industryType,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (userId != null) 'user_id': userId,
      'submission_type': submissionType.toString(),
      'organisation_name': organisationName,
      'industry_type': industryType,
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
      status: json['status'] as String?,
    );
  }
}
