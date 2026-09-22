import 'dart:typed_data';

import 'package:data/get_involved/models/get_involved_submission.dart';
import 'package:data/get_involved/models/submission_document.dart';

abstract class GetInvolvedDataSource {
  /// Creates a new submission, returns the created row (including its id and
  /// default status).
  Future<GetInvolvedSubmission> createSubmission(
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

  /// Returns the submissions made by the given user.
  Future<List<GetInvolvedSubmission>> fetchSubmissionsByUser(String userId);
}
