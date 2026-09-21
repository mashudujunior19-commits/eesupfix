import 'package:data/get_involved/models/get_involved_application.dart';
import 'package:data/get_involved/models/get_involved_application_type.dart';

enum GetInvolvedSubmitStatus {
  init,
  success,
  failed,
}

class GetInvolvedForm {
  final GetInvolvedApplicationType applicationType;
  final String? businessName;
  final String? firstName;
  final String? lastName;
  final String? businessType;
  final bool isLoading;
  final GetInvolvedSubmitStatus status;
  final String? errorMessage;

  const GetInvolvedForm({
    required this.applicationType,
    this.businessName,
    this.firstName,
    this.lastName,
    this.businessType,
    required this.isLoading,
    required this.status,
    this.errorMessage,
  });

  factory GetInvolvedForm.initial() => const GetInvolvedForm(
        applicationType: GetInvolvedApplicationType.registered,
        isLoading: false,
        status: GetInvolvedSubmitStatus.init,
      );

  bool get isRegistered =>
      applicationType == GetInvolvedApplicationType.registered;

  GetInvolvedForm copyWith({
    GetInvolvedApplicationType? applicationType,
    String? businessName,
    String? firstName,
    String? lastName,
    String? businessType,
    bool? isLoading,
    GetInvolvedSubmitStatus? status,
    String? errorMessage,
  }) {
    return GetInvolvedForm(
      applicationType: applicationType ?? this.applicationType,
      businessName: businessName ?? this.businessName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      businessType: businessType ?? this.businessType,
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  GetInvolvedApplication toApplication() {
    return GetInvolvedApplication(
      applicationType: applicationType,
      businessType: businessType!,
      businessName: isRegistered ? businessName : null,
      firstName: !isRegistered ? firstName : null,
      lastName: !isRegistered ? lastName : null,
    );
  }
}
