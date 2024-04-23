import 'package:either_dart/either.dart';
import 'package:data_sources/referrals/data_source/referrals_data_source.dart';
import 'package:data_sources/referrals/models/referral.dart';
import 'package:repository/auth/auth_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

class ReferralsRepository {
  late final AuthRepository _authRepository;
  late final ReferralsDataSource _referralsDataSource;

  ReferralsRepository(this._authRepository, this._referralsDataSource);

  Future<Either<EESUpException, List<Referral>>> fetchReferrals() async {
    final results = await _authRepository.executeFutureWithAuth(
      (id) => _referralsDataSource.fetchReferrals(id),
    );
    return results;
  }
}
