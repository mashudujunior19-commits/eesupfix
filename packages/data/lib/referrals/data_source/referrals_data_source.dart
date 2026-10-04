import 'package:data/referrals/models/referral.dart';

abstract class ReferralsDataSource {
  ///Gets all users referrals
  Future<List<Referral>> fetchReferrals(String userId);

  /// The app's store listing URLs (from `version_control`), used to build
  /// referral links.
  Future<({String? android, String? ios})> fetchStoreUrls();
}
