import 'package:data/get_involved/models/contact_person.dart';
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

/// The fixed set of industry types selectable when registering an
/// organisation or a business -- also what an Ubuntunist chooses between
/// when donating their Social Wallet to a KasiLift organisation, and what
/// organisations report against. Kept as plain strings (not a DB enum) so
/// the value set can be extended without a schema migration -- see
/// `industry_type`/`services.get_involved_submissions` in the Supabase
/// migrations.
const List<String> industryTypeOptions = [
  'Social & welfare',
  'Education & training',
  'Economic development',
  'Community development',
  'Health',
  'Environment',
  'Religion',
  'Culture & heritage',
  'Sport & recreation',
  'Research',
  'Housing / community facilities',
  'Advocacy',
  'Professional / group interests',
];

/// South Africa's nine provinces, offered as a fixed dropdown so the value
/// stored on a Registered NPO's submission is always one of a known set.
const List<String> provinceOptions = [
  'Eastern Cape',
  'Free State',
  'Gauteng',
  'KwaZulu-Natal',
  'Limpopo',
  'Mpumalanga',
  'North West',
  'Northern Cape',
  'Western Cape',
];

class OrganisationForm {
  final OrganisationKind? orgKind;
  final RegistrationStatus? registrationStatus;
  final String? organisationName;
  final String? industryType;
  final String? address;
  final String? province;
  final String? socialDevelopmentNumber;
  final bool isKasilift;
  final String? aboutUs;
  final List<ContactPerson> contactPersons;
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
    this.address,
    this.province,
    this.socialDevelopmentNumber,
    this.isKasilift = false,
    this.aboutUs,
    this.contactPersons = const [],
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
        contactPersons: [ContactPerson(email: '', phone: '')],
      );

  bool get isNPO => orgKind == OrganisationKind.publicBenefit;
  bool get isRegistered => registrationStatus == RegistrationStatus.registered;
  bool get isUnregistered =>
      registrationStatus == RegistrationStatus.unregistered;

  GetInvolvedSubmissionType get submissionType =>
      GetInvolvedSubmissionType.from(isNPO: isNPO, isRegistered: isRegistered);

  /// Every combination except Form D (Unregistered Business) collects an
  /// address and up to a few contact persons.
  bool get requiresOrganisationDetails => isNPO || isRegistered;

  /// Only Registered NPOs collect the NPO's Department of Social
  /// Development registration number.
  bool get requiresSocialDevelopmentNumber => isNPO && isRegistered;

  /// Only Registered NPOs collect a Province (in addition to Address).
  bool get requiresProvince => isNPO && isRegistered;

  /// Every combination that collects organisation details may list up to 3
  /// contact persons (a stokvel or soccer club, while unregistered, still
  /// needs more than one contact).
  int get maxContactPersons => requiresOrganisationDetails ? 3 : 0;

  /// Documents required for this (org kind, registration status)
  /// combination once KasiLift participation is active -- see
  /// [requiredDocumentTypes], which gates these behind [isKasilift].
  List<DocumentType> get baseRequiredDocumentTypes =>
      submissionType.baseRequiredDocumentTypes;

  List<DocumentType> get baseOptionalDocumentTypes =>
      submissionType.baseOptionalDocumentTypes;

  /// Documents that must be uploaded before the form can be submitted.
  ///
  /// KasiLift opt-in only applies to organisations (NPOs) -- for those,
  /// supporting documents are only mandatory once the applicant opts into
  /// KasiLift (see [isKasilift]), otherwise every document is optional. For
  /// businesses (which never opt into KasiLift) the base required set always
  /// applies unchanged.
  List<DocumentType> get requiredDocumentTypes {
    if (!isNPO) return baseRequiredDocumentTypes;
    return isKasilift ? baseRequiredDocumentTypes : const [];
  }

  /// Documents that may optionally be uploaded for the current combination.
  List<DocumentType> get optionalDocumentTypes {
    if (!isNPO) return baseOptionalDocumentTypes;
    if (isKasilift) return baseOptionalDocumentTypes;
    return [...baseRequiredDocumentTypes, ...baseOptionalDocumentTypes];
  }

  bool get hasAllRequiredDocuments => requiredDocumentTypes
      .every((type) => pickedDocuments[type] != null);

  bool get hasValidContactPersons {
    if (!requiresOrganisationDetails) return true;
    final first = contactPersons.isEmpty ? null : contactPersons.first;
    return first != null &&
        (first.name?.trim().isNotEmpty ?? false) &&
        first.email.trim().isNotEmpty &&
        first.phone.trim().isNotEmpty;
  }

  bool get hasValidKasiliftDetails =>
      !isKasilift || (aboutUs != null && aboutUs!.trim().isNotEmpty);

  /// Sentinel used by [updateDetails] to distinguish "leave this field
  /// alone" from "clear this field to null" -- unlike [copyWith]'s `??`
  /// fallback, this lets a field actually be set back to null (e.g. when a
  /// user backspaces a text field down to empty).
  static const _unset = Object();

  OrganisationForm updateDetails({
    Object? organisationName = _unset,
    Object? industryType = _unset,
    Object? address = _unset,
    Object? province = _unset,
    Object? socialDevelopmentNumber = _unset,
    Object? aboutUs = _unset,
  }) {
    return OrganisationForm(
      orgKind: orgKind,
      registrationStatus: registrationStatus,
      organisationName: identical(organisationName, _unset)
          ? this.organisationName
          : organisationName as String?,
      industryType: identical(industryType, _unset)
          ? this.industryType
          : industryType as String?,
      address:
          identical(address, _unset) ? this.address : address as String?,
      province:
          identical(province, _unset) ? this.province : province as String?,
      socialDevelopmentNumber: identical(socialDevelopmentNumber, _unset)
          ? this.socialDevelopmentNumber
          : socialDevelopmentNumber as String?,
      isKasilift: isKasilift,
      aboutUs:
          identical(aboutUs, _unset) ? this.aboutUs : aboutUs as String?,
      contactPersons: contactPersons,
      submissionId: submissionId,
      pickedDocuments: pickedDocuments,
      uploadedDocumentPaths: uploadedDocumentPaths,
      uploadingDocuments: uploadingDocuments,
      isLoading: isLoading,
      status: status,
      errorMessage: errorMessage,
    );
  }

  OrganisationForm copyWith({
    OrganisationKind? orgKind,
    RegistrationStatus? registrationStatus,
    String? organisationName,
    String? industryType,
    String? address,
    String? province,
    String? socialDevelopmentNumber,
    bool? isKasilift,
    String? aboutUs,
    List<ContactPerson>? contactPersons,
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
      address: address ?? this.address,
      province: province ?? this.province,
      socialDevelopmentNumber:
          socialDevelopmentNumber ?? this.socialDevelopmentNumber,
      isKasilift: isKasilift ?? this.isKasilift,
      aboutUs: aboutUs ?? this.aboutUs,
      contactPersons: contactPersons ?? this.contactPersons,
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
      address: requiresOrganisationDetails ? address : null,
      province: requiresProvince ? province : null,
      socialDevelopmentNumber:
          requiresSocialDevelopmentNumber ? socialDevelopmentNumber : null,
      isKasilift: isKasilift,
      aboutUs: isKasilift ? aboutUs : null,
    );
  }

  /// Contact persons with all fields filled in, ready to persist.
  List<ContactPerson> get contactPersonsToSave {
    if (!requiresOrganisationDetails) return const [];
    return contactPersons
        .where((c) =>
            (c.name?.trim().isNotEmpty ?? false) &&
            c.email.trim().isNotEmpty &&
            c.phone.trim().isNotEmpty)
        .toList();
  }
}
