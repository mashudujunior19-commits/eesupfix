import 'package:eesup_dart_frog/src/auth/data/providers/auth_supabase_impl.dart';

class AuthRepository {
  AuthRepository(this._authProvider);
  final AuthProvider _authProvider;

  Future<bool> isAuthorized({required String key}) async {
    try {
      final results = await _authProvider.verifyAuthKey(key: key);
      return results;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }
}
