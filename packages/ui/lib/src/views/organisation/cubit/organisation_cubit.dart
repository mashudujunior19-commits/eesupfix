import 'package:bloc/bloc.dart';
import 'package:data/get_involved/models/contact_person.dart';
import 'package:data/get_involved/models/contact_person_role.dart';
import 'package:data/get_involved/models/document_type.dart';
import 'package:data/get_involved/models/picked_document.dart';
import 'package:data/auth/models/profile.dart';
import 'package:data/auth/repository/profile_repository.dart';
import 'package:data/geolocation/models/address.dart';
import 'package:data/geolocation/repository/geo_repository.dart';
import 'package:data/get_involved/repository/get_involved_repository.dart';
import 'package:ui/src/views/organisation/cubit/organisation_form.dart';

class OrganisationCubit extends Cubit<OrganisationForm> {
  final GetInvolvedRepository _getInvolvedRepository;
  bool _isSubmitting = false;

  OrganisationCubit(this._getInvolvedRepository)
      : super(OrganisationForm.initial());

  /// The user's saved addresses, offered so an address is never re-typed.
  List<Address> savedAddresses = const [];

  /// Bumped whenever the form is filled programmatically (profile defaults,
  /// picking a saved address) so the text fields, which only read their
  /// `initialValue` once, are rebuilt to show the new values.
  int prefillEpoch = 0;

  /// Pre-fills the first contact person (name, email, phone) -- and the
  /// organisation name for a corporate profile -- from the user's profile, and
  /// loads their saved addresses.
  Future<void> loadDefaults(
    ProfileRepository profiles,
    GeoRepository geo,
  ) async {
    final profile = (await profiles.fetchSessionProfile()).fold((_) => null, (p) => p);
    final addresses =
        (await geo.fetchUserAddresses()).fold((_) => <Address>[], (a) => a);
    if (isClosed) return;
    savedAddresses = addresses;
    if (profile != null) _prefillFromProfile(profile);
    prefillEpoch++;
    emit(state.copyWith());
  }

  void _prefillFromProfile(Profile profile) {
    bool blank(String? v) => v == null || v.trim().isEmpty;
    final fullName = [profile.firstName, profile.lastName]
        .where((e) => !blank(e))
        .join(' ');
    final name = fullName.isNotEmpty ? fullName : profile.corpName;

    final contacts = [...state.contactPersons];
    if (contacts.isNotEmpty) {
      final first = contacts.first;
      contacts[0] = ContactPerson(
        id: first.id,
        submissionId: first.submissionId,
        name: blank(first.name) ? name : first.name,
        email: blank(first.email) ? (profile.email ?? '') : first.email,
        phone: blank(first.phone) ? (profile.phone ?? '') : first.phone,
        role: first.role,
      );
    }
    var form = state.copyWith(contactPersons: contacts);
    if (blank(form.organisationName) && !blank(profile.corpName)) {
      form = form.updateDetails(organisationName: profile.corpName);
    }
    emit(form);
  }

  /// Uses one of the user's saved addresses for the organisation's address
  /// (and province when it is one of the offered provinces).
  void useSavedAddress(Address address) {
    final parts = <String>[];
    for (final part in [
      address.streetAddress,
      address.suburb,
      address.city,
      address.postalCode,
    ]) {
      final p = part?.trim() ?? '';
      if (p.isNotEmpty && !parts.contains(p)) parts.add(p);
    }
    prefillEpoch++;
    emit(state.updateDetails(
      address: parts.join(', '),
      province: provinceOptions.contains(address.province)
          ? address.province
          : state.province,
    ));
  }

  void updateForm(OrganisationForm form) => emit(form);

  void pickDocument(DocumentType type, PickedDocument document) {
    emit(
      state.copyWith(
        pickedDocuments: {...state.pickedDocuments, type: document},
      ),
    );
  }

  /// Replaces the contact person at [index] outright with the given field
  /// values (the caller -- [_ContactPersonFields] -- always passes the
  /// current value of every field alongside the one actually being edited,
  /// rather than a partial update; this sidesteps `copyWith`'s usual
  /// can't-clear-to-null problem entirely, since there's nothing to
  /// distinguish "not touched" from "cleared" here).
  void updateContactPerson(
    int index, {
    String? name,
    required String email,
    required String phone,
    ContactPersonRole? role,
  }) {
    final contacts = [...state.contactPersons];
    final existing = contacts[index];
    contacts[index] = ContactPerson(
      id: existing.id,
      submissionId: existing.submissionId,
      name: name,
      email: email,
      phone: phone,
      role: role,
    );
    emit(state.copyWith(contactPersons: contacts));
  }

  void addContactPerson() {
    if (state.contactPersons.length >= state.maxContactPersons) return;
    emit(
      state.copyWith(
        contactPersons: [
          ...state.contactPersons,
          const ContactPerson(email: '', phone: ''),
        ],
      ),
    );
  }

  void removeContactPerson(int index) {
    final contacts = [...state.contactPersons]..removeAt(index);
    emit(state.copyWith(contactPersons: contacts));
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

    final contactsToSave = state.contactPersonsToSave;
    if (contactsToSave.isNotEmpty) {
      final contactsResult = await _getInvolvedRepository.saveContactPersons(
        submissionId: submissionId,
        contactPersons: contactsToSave,
      );
      final contactsFailure = contactsResult.fold((left) => left, (_) => null);
      if (contactsFailure != null) {
        _isSubmitting = false;
        emit(
          state.copyWith(
            isLoading: false,
            status: OrganisationSubmitStatus.failed,
            errorMessage: 'Failed to save contact details. Please try again.',
          ),
        );
        return;
      }
    }

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
