import 'package:bloc/bloc.dart';
import 'package:data/get_involved/models/document_type.dart';
import 'package:data/get_involved/models/picked_document.dart';
import 'package:data/get_involved/repository/get_involved_repository.dart';
import 'package:ui/src/views/organisation/cubit/organisation_form.dart';

class OrganisationCubit extends Cubit<OrganisationForm> {
  final GetInvolvedRepository _getInvolvedRepository;
  bool _isSubmitting = false;

  OrganisationCubit(this._getInvolvedRepository)
      : super(OrganisationForm.initial());

  void updateForm(OrganisationForm form) => emit(form);

  void pickDocument(DocumentType type, PickedDocument document) {
    emit(
      state.copyWith(
        pickedDocuments: {...state.pickedDocuments, type: document},
      ),
    );
  }

  Future<void> submit() async {
    if (_isSubmitting) return;
    _isSubmitting = true;

    emit(state.copyWith(isLoading: true, errorMessage: null));

    final submissionResult =
        await _getInvolvedRepository.submitApplication(state.toSubmission());

    final failure = submissionResult.fold(
      (left) => left,
      (right) => null,
    );

    if (failure != null) {
      _isSubmitting = false;
      emit(
        state.copyWith(
          isLoading: false,
          status: OrganisationSubmitStatus.failed,
          errorMessage: failure.message,
        ),
      );
      return;
    }

    final submission = submissionResult.fold((_) => null, (right) => right);
    final submissionId = submission!.id!;
    emit(state.copyWith(submissionId: submissionId));

    final docsToUpload = {
      ...state.pickedDocuments,
    }..removeWhere((_, document) => document == null);

    for (final entry in docsToUpload.entries) {
      final type = entry.key;
      final document = entry.value!;

      emit(
        state.copyWith(
          uploadingDocuments: {...state.uploadingDocuments, type},
        ),
      );

      final uploadResult = await _getInvolvedRepository.uploadDocument(
        submissionId: submissionId,
        documentType: type,
        document: document,
      );

      final stillUploading = {...state.uploadingDocuments}..remove(type);

      final uploadFailure = uploadResult.fold((left) => left, (_) => null);
      if (uploadFailure != null && state.requiredDocumentTypes.contains(type)) {
        _isSubmitting = false;
        emit(
          state.copyWith(
            isLoading: false,
            uploadingDocuments: stillUploading,
            status: OrganisationSubmitStatus.failed,
            errorMessage:
                'Failed to upload a required document. Please try again.',
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          uploadingDocuments: stillUploading,
          uploadedDocumentPaths: {
            ...state.uploadedDocumentPaths,
            type: uploadResult.fold((_) => null, (right) => right.filePath),
          },
        ),
      );
    }

    _isSubmitting = false;
    emit(
      state.copyWith(
        isLoading: false,
        status: OrganisationSubmitStatus.success,
      ),
    );
  }
}
