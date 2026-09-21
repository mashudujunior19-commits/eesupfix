import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/get_involved/data_source/get_involved_data_source.dart';
import 'package:data/get_involved/models/get_involved_application.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';

class GetInvolvedRepository {
  final AuthRepository authRepository;
  final GetInvolvedDataSource dataSource;

  GetInvolvedRepository({
    required this.authRepository,
    required this.dataSource,
  });

  Future<Either<EESUpException, GetInvolvedApplication>> submitApplication(
    GetInvolvedApplication application,
  ) async {
    final result = authRepository.executeFutureWithAuth((id) {
      return dataSource.createApplication(
        application.copyWith(userId: id),
      );
    });
    return result;
  }

  Future<Either<EESUpException, List<GetInvolvedApplication>>>
      fetchMyApplications() async {
    final result = authRepository.executeFutureWithAuth((id) {
      return dataSource.fetchApplicationsByUser(id);
    });
    return result;
  }
}
