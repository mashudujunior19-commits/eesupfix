import 'dart:typed_data';

import 'package:data/get_involved/models/contact_person.dart';
import 'package:data/get_involved/models/get_involved_submission.dart';
import 'package:data/get_involved/models/business_profile.dart';
import 'package:data/get_involved/models/profile_switch_state.dart';
import 'package:data/get_involved/models/submission_document.dart';

abstract class GetInvolvedDataSource {
  /// Creates a new submission, returns the created row (including its id and
  /// default status).
  Future<GetInvolvedSubmission> createSubmission(
    GetInvolvedSubmission submission,
  );

  /// Updates an existing submission (e.g. opting into KasiLift after the
  /// initial registration -- see [GetInvolvedSubmission.isKasilift]).
  Future<GetInvolvedSubmission> updateSubmission(
    GetInvolvedSubmission submission,
  );

  /// Uploads a supporting document to private storage and returns the
  /// storage path (not a public URL -- these documents are sensitive).
  ///
  /// Takes raw bytes (rather than a `dart:io` `File`) so this works on
  /// Flutter Web, where picked files never have a real filesystem path.
  Future<String?> uploadDocumentFile(String path, Uint8List bytes);

  /// Records an uploaded document against a submission.
  Future<SubmissionDocument> attachDocument(SubmissionDocument document);

  /// Records the contact persons (up to 3) for a submission in one batch
  /// insert.
  Future<List<ContactPerson>> attachContactPersons(
    String submissionId,
    List<ContactPerson> contactPersons,
  );

  /// Returns the submissions made by the given user.
  Future<List<GetInvolvedSubmission>> fetchSubmissionsByUser(String userId);

  /// Asks the server to make the signed-in user a Kasipromoter. Only a
  /// KasiLift Organisation may be one; for anyone else [ok] is false and
  /// [message] is the exact text to show.
  Future<({bool ok, String? message})> becomeKasipromoter();

  /// Same rule, without changing anything: lets the app explain before
  /// the user tries.
  Future<({bool ok, String? message})> kasipromoterEligibility();

  /// Whether this account may switch profiles, and which one is active.
  Future<ProfileSwitchState> profileSwitchState();

  /// Switches to the Business profile ([toBusiness]) or back to the Individual
  /// one. Only allowed once a Get Involved application is approved.
  Future<ProfileSwitchState> switchProfile({required bool toBusiness});

  /// The business registered through Get Involved, once approved.
  Future<BusinessProfile?> businessProfile();
}
