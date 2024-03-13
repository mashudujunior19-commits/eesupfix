import 'package:dartz/dartz.dart';
import 'package:eesup_data_source/referrals/data_source/referrals_data_source.dart';
import 'package:eesup_data_source/referrals/models/referral.dart';
import 'package:eesup_repository/auth/auth_repository.dart';
import 'package:eesup_repository/utils/eesup_exception.dart';


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
