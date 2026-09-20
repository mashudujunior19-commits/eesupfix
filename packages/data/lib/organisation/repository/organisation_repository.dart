import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/organisation/data_source/organisation_data_source.dart';
import 'package:data/organisation/models/organisation.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';

class OrganisationRepository {
  final AuthRepository authRepository;
  final OrganisationDataSource dataSource;

  OrganisationRepository({
    required this.authRepository,
    required this.dataSource,
  });

  Future<Either<EESUpException, Organisation>> registerOrganisation(
    Organisation organisation,
  ) async {
    final result = authRepository.executeFutureWithAuth((id) {
      return dataSource.createOrganisation(
        organisation.copyWith(ownerId: id),
      );
    });
    return result;
  }

  Future<Either<EESUpException, List<Organisation>>> fetchMyOrganisations() async {
    final result = authRepository.executeFutureWithAuth((id) {
      return dataSource.fetchOrganisationsByOwner(id);
    });
    return result;
  }
}
