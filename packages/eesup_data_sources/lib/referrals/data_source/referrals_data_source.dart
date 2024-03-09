

import 'package:eesup_data_source/referrals/models/referral.dart';


abstract class ReferralsDataSource {
  ///Gets all users referrals
  Future<List<Referral>> fetchReferrals(String userId);
}
