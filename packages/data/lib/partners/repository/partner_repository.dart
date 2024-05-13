import 'package:data/auth/models/user_role.dart';
import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:data/partners/data_source/partner_data_source.dart';
import 'package:data/partners/models/partner.dart';
import 'package:data/partners/models/partner_application.dart';
import 'package:data/surveys/models/survey.dart';

class PartnerRepository {
  final PartnerDataSource dataSource;
  final AuthRepository authRepo;

  PartnerRepository(this.dataSource, this.authRepo);

  Future<Either<EESUpException, List<Partner>>> fetchPartnerships(
      UserRole role) async {
    final results = await authRepo.executeFutureWithAuth((_) {
      return dataSource.fetchPartnerships(role);
    });
    return results;
  }

  Future<Either<EESUpException, List<PartnerApplication>>>
      fetchPartnerApplications(
    String partnerId,
  ) async {
    final results = await authRepo.executeFutureWithAuth((id) {
      return dataSource.fetchPartnerApplications(id, partnerId);
    });
    return results;
  }

  Future<Either<EESUpException, int>> createPartnerApplications(
    String partnerId,
  ) async {
    final results = await authRepo.executeFutureWithAuth((id) {
      return dataSource.createPartnerApplications(id, partnerId);
    });
    return results;
  }

  Future<Either<EESUpException, List<Survey>>> fetchPartnerSurveys(
    List<String> surveys,
  ) async {
    final results = await authRepo.executeFutureWithAuth((id) {
      return dataSource.fetchPartnerShipSurveys(id, surveys);
    });
    return results;
  }

  Future<Either<EESUpException, bool>> updatePartnerSurveys(
    PartnerApplication app,
  ) async {
    final results = await authRepo.executeFutureWithAuth((id) {
      return dataSource.updatePartnerApplications(app.copyWith(userId: id));
    });
    return results;
  }
}
