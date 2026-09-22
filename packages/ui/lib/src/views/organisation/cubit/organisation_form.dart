import 'package:data/get_involved/models/document_type.dart';
import 'package:data/get_involved/models/get_involved_submission.dart';
import 'package:data/get_involved/models/get_involved_submission_type.dart';
import 'package:data/get_involved/models/picked_document.dart';

enum OrganisationKind { publicBenefit, business }

enum RegistrationStatus { registered, unregistered }

enum OrganisationSubmitStatus {
  init,
  success,
  failed,
}

class OrganisationForm {
  final OrganisationKind? orgKind;
  final RegistrationStatus? registrationStatus;
  final String? organisationName;
  final String? industryType;
  final String? submissionId;
  final Map<DocumentType, PickedDocument?> pickedDocuments;
  final Map<DocumentType, String?> uploadedDocumentPaths;
  final Set<DocumentType> uploadingDocuments;
  final bool isLoading;
  final OrganisationSubmitStatus status;
  final String? errorMessage;

  const OrganisationForm({
    this.orgKind,
    this.registrationStatus,
    this.organisationName,
    this.industryType,
    this.submissionId,
    this.pickedDocuments = const {},
    this.uploadedDocumentPaths = const {},
    this.uploadingDocuments = const {},
    required this.isLoading,
    required this.status,
    this.errorMessage,
  });

  factory OrganisationForm.initial() => const OrganisationForm(
        isLoading: false,
        status: OrganisationSubmitStatus.init,
      );

  bool get isNPO => orgKind == OrganisationKind.publicBenefit;
  bool get isRegistered => registrationStatus == RegistrationStatus.registered;
  bool get isUnregistered =>
      registrationStatus == RegistrationStatus.unregistered;

  GetInvolvedSubmissionType get submissionType =>
      GetInvolvedSubmissionType.from(isNPO: isNPO, isRegistered: isRegistered);

  /// Documents that must be uploaded before the form for the current
  /// (org kind, registration status) combination can be submitted.
  List<DocumentType> get requiredDocumentTypes {
    if (isNPO && isRegistered) {
      // Form A: Registered NPO
      return const [
        DocumentType.businessRegistration,
        DocumentType.proofOfBank,
        DocumentType.proofOfResidence,
      ];
    }
    if (isNPO && isUnregistered) {
      // Form B: Unregistered NPO
      return const [
        DocumentType.proofOfBank,
        DocumentType.proofOfResidence,
        DocumentType.constitution,
      ];
    }
    if (!isNPO && isRegistered) {
      // Form C: Registered Business
      return const [
        DocumentType.cipcDocument,
        DocumentType.proofOfResidence,
      ];
    }
    // Form D: Unregistered Business
    return const [DocumentType.proofOfBank];
  }

  /// Documents that may optionally be uploaded for the current combination.
  List<DocumentType> get optionalDocumentTypes {
    if (isNPO && isRegistered) {
      return const [DocumentType.pboCertificate];
    }
    if (!isNPO && isRegistered) {
      return const [DocumentType.proofOfBank, DocumentType.vatDocument];
    }
    return const [];
  }

  bool get hasAllRequiredDocuments => requiredDocumentTypes
      .every((type) => pickedDocuments[type] != null);

  OrganisationForm copyWith({
    OrganisationKind? orgKind,
    RegistrationStatus? registrationStatus,
    String? organisationName,
    String? industryType,
    String? submissionId,
    Map<DocumentType, PickedDocument?>? pickedDocuments,
    Map<DocumentType, String?>? uploadedDocumentPaths,
    Set<DocumentType>? uploadingDocuments,
    bool? isLoading,
    OrganisationSubmitStatus? status,
    String? errorMessage,
  }) {
    return OrganisationForm(
      orgKind: orgKind ?? this.orgKind,
      registrationStatus: registrationStatus ?? this.registrationStatus,
      organisationName: organisationName ?? this.organisationName,
      industryType: industryType ?? this.industryType,
      submissionId: submissionId ?? this.submissionId,
      pickedDocuments: pickedDocuments ?? this.pickedDocuments,
      uploadedDocumentPaths:
          uploadedDocumentPaths ?? this.uploadedDocumentPaths,
      uploadingDocuments: uploadingDocuments ?? this.uploadingDocuments,
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  GetInvolvedSubmission toSubmission() {
    return GetInvolvedSubmission(
      submissionType: submissionType,
      organisationName: organisationName!,
      industryType: industryType!,
    );
  }
}
