import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:data/referrals/data_source/referrals_data_source.dart';
import 'package:data/referrals/models/referral.dart';
import 'auth_repository.dart';

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
