import 'package:eesup_dart_frog/src/auth/data/data_source/auth_api.dart';
import 'package:supabase/supabase.dart';

class AuthSupabaseImpl implements AuthApi {
  AuthSupabaseImpl(this._supabase);
  final SupabaseClient _supabase;

  @override
  Future<bool> checkKey({required String key}) async {
    try {
      final table = _supabase.schema('system_configs').from('api_key');
      final res = await table.select().eq('key', key);
      return res.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> generateKey({required String name}) {
    // TODO: implement generateKey
    throw UnimplementedError();
  }
}
