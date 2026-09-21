import 'package:data/get_involved/models/get_involved_application.dart';

abstract class GetInvolvedDataSource {
  /// Submits a new "Get Involved" application, returns the created row.
  Future<GetInvolvedApplication> createApplication(
    GetInvolvedApplication application,
  );

  /// Returns the applications submitted by the given user.
  Future<List<GetInvolvedApplication>> fetchApplicationsByUser(String userId);
}
