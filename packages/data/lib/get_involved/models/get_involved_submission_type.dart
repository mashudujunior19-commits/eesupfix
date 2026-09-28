import 'package:data/get_involved/models/document_type.dart';

enum GetInvolvedSubmissionType {
  registeredNpo,
  unregisteredNpo,
  registeredBusiness,
  unregisteredBusiness;

  bool get isNPO =>
      this == GetInvolvedSubmissionType.registeredNpo ||
      this == GetInvolvedSubmissionType.unregisteredNpo;

  bool get isRegistered =>
      this == GetInvolvedSubmissionType.registeredNpo ||
      this == GetInvolvedSubmissionType.registeredBusiness;

  @override
  String toString() {
    switch (this) {
      case GetInvolvedSubmissionType.registeredNpo:
        return 'registered_npo';
      case GetInvolvedSubmissionType.unregisteredNpo:
        return 'unregistered_npo';
      case GetInvolvedSubmissionType.registeredBusiness:
        return 'registered_business';
      case GetInvolvedSubmissionType.unregisteredBusiness:
        return 'unregistered_business';
    }
  }

  factory GetInvolvedSubmissionType.fromString(String value) {
    switch (value) {
      case 'registered_npo':
        return GetInvolvedSubmissionType.registeredNpo;
      case 'unregistered_npo':
        return GetInvolvedSubmissionType.unregisteredNpo;
      case 'registered_business':
        return GetInvolvedSubmissionType.registeredBusiness;
      case 'unregistered_business':
        return GetInvolvedSubmissionType.unregisteredBusiness;
      default:
        throw Exception('Unknown get involved submission type: $value');
    }
  }

  factory GetInvolvedSubmissionType.from({
    required bool isNPO,
    required bool isRegistered,
  }) {
    if (isNPO) {
      return isRegistered
          ? GetInvolvedSubmissionType.registeredNpo
          : GetInvolvedSubmissionType.unregisteredNpo;
    }
    return isRegistered
        ? GetInvolvedSubmissionType.registeredBusiness
        : GetInvolvedSubmissionType.unregisteredBusiness;
  }

  /// Documents required for a KasiLift submission of this type, before
  /// KasiLift opt-in is taken into account (see
  /// `OrganisationForm.requiredDocumentTypes`, which gates these behind
  /// `isKasilift`). Shared with the standalone "upgrade to KasiLift" flow so
  /// the required-document set for a given type is defined in one place.
  List<DocumentType> get baseRequiredDocumentTypes {
    switch (this) {
      case GetInvolvedSubmissionType.registeredNpo:
        return const [
          DocumentType.businessRegistration,
          DocumentType.proofOfBank,
          DocumentType.proofOfResidence,
        ];
      case GetInvolvedSubmissionType.unregisteredNpo:
        return const [
          DocumentType.proofOfBank,
          DocumentType.proofOfResidence,
          DocumentType.constitution,
        ];
      case GetInvolvedSubmissionType.registeredBusiness:
        return const [
          DocumentType.cipcDocument,
          DocumentType.proofOfResidence,
        ];
      case GetInvolvedSubmissionType.unregisteredBusiness:
        // Bank details are optional for informal businesses -- registration
        // should be frictionless; they're caught later at Cash payout time.
        return const [];
    }
  }

  /// Documents that may optionally be uploaded for this type, before
  /// KasiLift opt-in is taken into account.
  List<DocumentType> get baseOptionalDocumentTypes {
    switch (this) {
      case GetInvolvedSubmissionType.registeredNpo:
        return const [DocumentType.pboCertificate];
      case GetInvolvedSubmissionType.registeredBusiness:
        return const [DocumentType.proofOfBank, DocumentType.vatDocument];
      case GetInvolvedSubmissionType.unregisteredNpo:
        return const [];
      case GetInvolvedSubmissionType.unregisteredBusiness:
        return const [DocumentType.proofOfBank];
    }
  }
}
