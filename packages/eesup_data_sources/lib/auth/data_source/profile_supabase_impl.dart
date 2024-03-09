import 'package:eesup_data_source/auth/data_source/profile_data_source.dart';
import 'package:eesup_data_source/auth/models/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileSupabaseImpl implements ProfileDataSource {
  final SupabaseClient _client;

  ProfileSupabaseImpl(this._client);

  @override
  Future<Profile?> fetchProfile(String id) async {
    final response = await _client
        .schema('public')
        .from('profile')
        .select()
        .eq('user_id', id)
        .single();
    return Profile.fromJson(response);
  }

  @override
  Future<bool> deactivateAccount(String id) async {
    try {
      await _client
          .from('profile')
          .update({'is_active': false}).eq('user_id', id);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  @override
  Future<bool> updateProfile(Profile profile) async {
    try {
      await _client.from('profile').update(profile.toJson()).eq(
            'user_id',
            profile.userId,
          );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
