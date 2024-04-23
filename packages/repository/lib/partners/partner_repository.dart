import 'package:either_dart/either.dart';
import 'package:data_sources/partners/data_source/partner_data_source.dart';
import 'package:data_sources/partners/models/partner.dart';
import 'package:data_sources/partners/models/partner_application.dart';
import 'package:data_sources/surveys/models/survey.dart';
import 'package:repository/auth/auth_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

class PartnerRepository {
  final PartnerDataSource dataSource;
  final AuthRepository authRepo;

  PartnerRepository(this.dataSource, this.authRepo);

  Future<Either<EESUpException, List<Partner>>> fetchPartnerships() async {
    final results = await authRepo.executeFutureWithAuth((_) {
      return dataSource.fetchPartnerships();
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
