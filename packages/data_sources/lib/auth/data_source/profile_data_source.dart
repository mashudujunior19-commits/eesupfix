import 'package:data_sources/auth/models/profile.dart';

abstract class ProfileDataSource {
  ///Fetches the profile of the user with the given [id]
  Future<Profile?> fetchProfile(String id);

  Future<bool> deactivateAccount(String id);

  Future<bool> updateProfile(Profile profile);
}
