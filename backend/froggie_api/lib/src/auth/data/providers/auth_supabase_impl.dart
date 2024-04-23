import 'package:supabase/supabase.dart';


abstract class AuthProvider {
  Future<bool> verifyAuthKey({required String key});
  Future<String> generateKey({required String name});
}


class AuthSupabaseProvider implements AuthProvider {
  AuthSupabaseProvider(this._supabase);
  final SupabaseClient _supabase;

  @override
  Future<bool> verifyAuthKey({required String key}) async {
    final table = _supabase.schema('system_configs').from('api_key');
    final res = await table.select().eq('key', key);
    return res.isNotEmpty;
  }

  @override
  Future<String> generateKey({required String name}) {
    // TODO: implement generateKey
    throw UnimplementedError();
  }
}
