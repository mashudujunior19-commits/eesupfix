import 'package:data/auth/models/profile.dart';

abstract class ProfileDataSource {
  ///Fetches the profile of the user with the given [id]
  Future<Profile?> fetchProfile(String id);

  Future<bool> deactivateAccount(String id);

  Future<bool> changePhone(String phone);

  Future<bool> changeEmail(String email);

  Future<bool> updateProfile(Profile profile);

  Future<bool> checkIdNumber(String id);

  Future<bool> checkIfhasAddress(String id);

  Future<Map<String, dynamic>?> checkCurrentAppVersion();
}
