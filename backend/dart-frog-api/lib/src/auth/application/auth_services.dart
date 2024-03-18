import 'package:eesup_dart_frog/src/auth/data/data_source/auth_api.dart';

class AuthServices {
  AuthServices(this._authApi);

  final AuthApi _authApi;

  Future<bool> authorized({required String key}) async {
    return _authApi.checkKey(key: key);
  }
}
