import 'package:data/auth/data_source/profile_data_source.dart';
import 'package:data/auth/models/profile.dart';
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

  @override
  Future<bool> changePhone(String phone) async {
    // final results =
    //     await _client.auth.updateUser(UserAttributes(phone: '+27618640746'));
    // print(results.user);
    final results = await _client.auth
        .updateUser(UserAttributes(email: 'miso@canbushack.com'));
    // final results = await _client.auth.verifyOTP(
    //     token: '885521', phone: '+27618640745', type: OtpType.phoneChange);
    print(results.user);
    return true;
  }

  @override
  Future<bool> changeEmail(String email) async {
    final results = await _client.auth
        .updateUser(UserAttributes(email: 'miso@canbushack.com'));  
    return true;
  }
}
