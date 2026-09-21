import 'package:data/get_involved/models/get_involved_application_type.dart';

class GetInvolvedApplication {
  final String? id;
  final String? userId;
  final DateTime? createdAt;
  final GetInvolvedApplicationType applicationType;
  final String? businessName;
  final String? firstName;
  final String? lastName;
  final String businessType;

  const GetInvolvedApplication({
    this.id,
    this.userId,
    this.createdAt,
    required this.applicationType,
    this.businessName,
    this.firstName,
    this.lastName,
    required this.businessType,
  });

  bool get isRegistered =>
      applicationType == GetInvolvedApplicationType.registered;

  GetInvolvedApplication copyWith({
    String? id,
    String? userId,
    DateTime? createdAt,
    GetInvolvedApplicationType? applicationType,
    String? businessName,
    String? firstName,
    String? lastName,
    String? businessType,
  }) {
    return GetInvolvedApplication(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      applicationType: applicationType ?? this.applicationType,
      businessName: businessName ?? this.businessName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      businessType: businessType ?? this.businessType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (userId != null) 'user_id': userId,
      'application_type': applicationType.toString(),
      'business_type': businessType,
      if (isRegistered) 'business_name': businessName,
      if (!isRegistered) 'first_name': firstName,
      if (!isRegistered) 'last_name': lastName,
    };
  }

  factory GetInvolvedApplication.fromJson(Map<String, dynamic> json) {
    return GetInvolvedApplication(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      applicationType: GetInvolvedApplicationType.fromString(
        json['application_type'] as String,
      ),
      businessName: json['business_name'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      businessType: json['business_type'] as String,
    );
  }
}
