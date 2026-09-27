import 'package:data/get_involved/models/document_type.dart';
import 'package:data/get_involved/models/get_involved_submission.dart';
import 'package:data/get_involved/models/picked_document.dart';

enum KasiliftUpgradeStatus {
  loading,
  noEligibleSubmissions,
  ready,
  submitting,
  success,
  failed,
}

class KasiliftUpgradeState {
  final KasiliftUpgradeStatus status;

  /// The user's existing submissions that haven't already opted into
  /// KasiLift.
  final List<GetInvolvedSubmission> eligibleSubmissions;
  final GetInvolvedSubmission? selected;
  final String? aboutUs;
  final Map<DocumentType, PickedDocument?> pickedDocuments;
  final Set<DocumentType> uploadingDocuments;
  final String? errorMessage;

  const KasiliftUpgradeState({
    required this.status,
    this.eligibleSubmissions = const [],
    this.selected,
    this.aboutUs,
    this.pickedDocuments = const {},
    this.uploadingDocuments = const {},
    this.errorMessage,
  });

  factory KasiliftUpgradeState.initial() =>
      const KasiliftUpgradeState(status: KasiliftUpgradeStatus.loading);

  List<DocumentType> get requiredDocumentTypes =>
      selected?.submissionType.baseRequiredDocumentTypes ?? const [];

  List<DocumentType> get optionalDocumentTypes =>
      selected?.submissionType.baseOptionalDocumentTypes ?? const [];

  bool get hasAllRequiredDocuments =>
      requiredDocumentTypes.every((type) => pickedDocuments[type] != null);

  bool get hasAboutUs => aboutUs != null && aboutUs!.trim().isNotEmpty;

  static const _unset = Object();

  KasiliftUpgradeState copyWith({
    KasiliftUpgradeStatus? status,
    List<GetInvolvedSubmission>? eligibleSubmissions,
    GetInvolvedSubmission? selected,
    Object? aboutUs = _unset,
    Map<DocumentType, PickedDocument?>? pickedDocuments,
    Set<DocumentType>? uploadingDocuments,
    String? errorMessage,
  }) {
    return KasiliftUpgradeState(
      status: status ?? this.status,
      eligibleSubmissions: eligibleSubmissions ?? this.eligibleSubmissions,
      selected: selected ?? this.selected,
      aboutUs: identical(aboutUs, _unset) ? this.aboutUs : aboutUs as String?,
      pickedDocuments: pickedDocuments ?? this.pickedDocuments,
      uploadingDocuments: uploadingDocuments ?? this.uploadingDocuments,
      errorMessage: errorMessage,
    );
  }
}
