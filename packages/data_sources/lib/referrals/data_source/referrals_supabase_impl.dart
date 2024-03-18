import 'package:data_sources/referrals/data_source/referrals_data_source.dart';
import 'package:data_sources/referrals/models/referral.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReferralsSupabaseImpl implements ReferralsDataSource {
  late final SupabaseClient _client;

  ReferralsSupabaseImpl(this._client);

  @override
  Future<List<Referral>> fetchReferrals(String userId) async {
    final res = await _client
        .schema('public')
        .rpc('get_referrals_by_referrer', params: {
      '_user_id': userId,
      '_limit_to': 100,
    });

    return (res as List).map((e) => Referral.fromJson(e)).toList();
  }
}
