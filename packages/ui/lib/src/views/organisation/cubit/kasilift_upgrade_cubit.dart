import 'package:bloc/bloc.dart';
import 'package:data/get_involved/models/document_type.dart';
import 'package:data/get_involved/models/get_involved_submission.dart';
import 'package:data/get_involved/models/picked_document.dart';
import 'package:data/get_involved/repository/get_involved_repository.dart';
import 'package:ui/src/views/organisation/cubit/kasilift_upgrade_state.dart';

/// Lets a user who has already submitted an (non-KasiLift) organisation or
/// business registration opt that existing submission into KasiLift later,
/// from the "Get Involved" tab -- without re-doing the whole registration
/// wizard.
class KasiliftUpgradeCubit extends Cubit<KasiliftUpgradeState> {
  final GetInvolvedRepository _repository;
  bool _isSubmitting = false;

  KasiliftUpgradeCubit(this._repository)
      : super(KasiliftUpgradeState.initial()) {
    _load();
  }

  Future<void> _load() async {
    final result = await _repository.fetchMySubmissions();
    result.fold(
      (left) => emit(
        state.copyWith(
          status: KasiliftUpgradeStatus.failed,
          errorMessage: left.message,
        ),
      ),
      (submissions) {
        // KasiLift is an NPO/organisation concept (tied to Ubuntunist
        // Social Wallet donations) -- business registrations aren't
        // eligible.
        final eligible = submissions
            .where((s) => !s.isKasilift && s.submissionType.isNPO)
            .toList();
        if (eligible.isEmpty) {
          emit(
            state.copyWith(status: KasiliftUpgradeStatus.noEligibleSubmissions),
          );
          return;
        }
        emit(
          state.copyWith(
            status: KasiliftUpgradeStatus.ready,
            eligibleSubmissions: eligible,
            selected: eligible.first,
          ),
        );
      },
    );
  }

  void selectSubmission(GetInvolvedSubmission submission) {
    emit(
      state.copyWith(
        selected: submission,
        aboutUs: null,
        pickedDocuments: const {},
      ),
    );
  }

  void updateAboutUs(String value) {
    emit(state.copyWith(aboutUs: value.isEmpty ? null : value));
  }

  void pickDocument(DocumentType type, PickedDocument document) {
    emit(
      state.copyWith(
        pickedDocuments: {...state.pickedDocuments, type: document},
      ),
    );
  }

  Future<void> submit() async {
    if (_isSubmitting || state.selected == null) return;
    _isSubmitting = true;
    emit(
      state.copyWith(
        status: KasiliftUpgradeStatus.submitting,
        errorMessage: null,
      ),
    );

    final updateResult = await _repository.updateSubmission(
      state.selected!.copyWith(isKasilift: true, aboutUs: state.aboutUs),
    );
    final updateFailure = updateResult.fold((left) => left, (_) => null);
    if (updateFailure != null) {
      _isSubmitting = false;
      emit(
        state.copyWith(
          status: KasiliftUpgradeStatus.failed,
          errorMessage: updateFailure.message,
        ),
      );
      return;
    }

    final submissionId = state.selected!.id!;
    final docsToUpload = {...state.pickedDocuments}
      ..removeWhere((_, document) => document == null);

    for (final entry in docsToUpload.entries) {
      final uploadResult = await _repository.uploadDocument(
        submissionId: submissionId,
        documentType: entry.key,
        document: entry.value!,
      );
      final uploadFailure = uploadResult.fold((left) => left, (_) => null);
      if (uploadFailure != null &&
          state.requiredDocumentTypes.contains(entry.key)) {
        _isSubmitting = false;
        emit(
          state.copyWith(
            status: KasiliftUpgradeStatus.failed,
            errorMessage: 'Failed to upload a required document. '
                'Please try again.',
          ),
        );
        return;
      }
    }

    _isSubmitting = false;
    emit(state.copyWith(status: KasiliftUpgradeStatus.success));
  }
}
