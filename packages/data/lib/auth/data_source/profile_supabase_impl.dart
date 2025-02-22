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
  Future<bool> checkIdNumber(String id) async {
    Profile? profile = await fetchProfile(id);
    if (profile == null) {
      return false;
    }
    if ((profile.rsaIdNumber == null || profile.rsaIdNumber!.isEmpty) ||
        profile.foreigner == false ||
        profile.foreigner == null) {
      return false;
    }
    return true;
  }

  @override
  Future<Map<String, dynamic>?> checkCurrentAppVersion() async {
    try {
      final response = await _client
          .schema('public')
          .from('version_control')
          .select(
              'version_number, build_number') // Select both version_number and build_number
          .eq('is_live', false) // Adjust this filter as necessary
          .limit(1)
          .single();

      return response as Map<String,
          dynamic>?; // Return both version number and build number
    } catch (e) {
      debugPrint('Error fetching latest app version: $e');
      return null;
    }
  }

// final response = await _client
//     .schema('public')
//     .from('version_control')
//     .select('*')
//     .eq('is_live', false)
//     .limit(1)
//     .single();

// final versionControl = VersionControl.fromJson(response);

  @override
  Future<bool> checkIfhasAddress(String id) async {
    try {
      final response = await _client
          .schema('geolocations')
          .from('address')
          .select('user_id, is_primary')
          .eq('user_id', id)
          .limit(1); // Only fetch one record

      if (response.isNotEmpty) {
        // Check if the address is marked as primary
        final address = response.first;
        return address['is_primary'] == true;
      }

      return false; // No address found
    } catch (e) {
      if (kDebugMode) {
        print('check address error : $e');
      }
      return false;
    }
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
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  @override
  Future<bool> changePhone(String phone) async {
    // final results =
    //     await _client.auth.updateUser(UserAttributes(phone: '+27618640746'));
    // print(results.user);
    // final results = await _client.auth
    //     .updateUser(UserAttributes(email: 'miso@canbushack.com'));
    // // final results = await _client.auth.verifyOTP(
    // //     token: '885521', phone: '+27618640745', type: OtpType.phoneChange);
    // print(results.user);
    return true;
  }

  @override
  Future<bool> changeEmail(String email) async {
    // final results = await _client.auth
    //     .updateUser(UserAttributes(email: 'miso@canbushack.com'));
    return true;
  }
}
