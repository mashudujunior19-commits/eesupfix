abstract class AuthApi {
  Future<bool> checkKey({required String key});

  Future<String> generateKey({required String name});
}
