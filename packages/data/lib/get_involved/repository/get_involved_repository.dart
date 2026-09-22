import 'dart:io';

import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/get_involved/data_source/get_involved_data_source.dart';
import 'package:data/get_involved/models/document_type.dart';
import 'package:data/get_involved/models/get_involved_submission.dart';
import 'package:data/get_involved/models/submission_document.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';

class GetInvolvedRepository {
  final AuthRepository authRepository;
  final GetInvolvedDataSource dataSource;

  GetInvolvedRepository({
    required this.authRepository,
    required this.dataSource,
  });

  Future<Either<EESUpException, GetInvolvedSubmission>> submitApplication(
    GetInvolvedSubmission submission,
  ) async {
    final result = authRepository.executeFutureWithAuth((id) {
      return dataSource.createSubmission(submission.copyWith(userId: id));
    });
    return result;
  }

  /// Uploads a single supporting document to private storage (scoped under
  /// the current user's own folder) and records it against [submissionId].
  Future<Either<EESUpException, SubmissionDocument>> uploadDocument({
    required String submissionId,
    required DocumentType documentType,
    required File file,
  }) async {
    final result = authRepository.executeFutureWithAuth((id) async {
      final ext = file.path.split('.').last;
      final path =
          '$id/$submissionId/${documentType}_${DateTime.now().millisecondsSinceEpoch}.$ext';
      final storedPath = await dataSource.uploadDocumentFile(path, file);
      if (storedPath == null) {
        throw EESUpException(message: 'Could not upload the document.');
      }
      return dataSource.attachDocument(
        SubmissionDocument(
          submissionId: submissionId,
          documentType: documentType,
          filePath: storedPath,
        ),
      );
    });
    return result;
  }

  Future<Either<EESUpException, List<GetInvolvedSubmission>>>
      fetchMySubmissions() async {
    final result = authRepository.executeFutureWithAuth((id) {
      return dataSource.fetchSubmissionsByUser(id);
    });
    return result;
  }
}
