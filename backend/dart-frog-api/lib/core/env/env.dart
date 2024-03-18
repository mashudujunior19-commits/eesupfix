import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(obfuscate: true, varName: 'SUPABASE_URL')
  static String supabaseUrl = _Env.supabaseUrl;

  @EnviedField(obfuscate: true, varName: 'SUPABASE_SERVICE_KEY')
  static String supabaseServiceKey = _Env.supabaseServiceKey;

  @EnviedField(obfuscate: true, varName: 'ONE_SIGNAL_APP_ID')
  static String oneSignalAppId = _Env.oneSignalAppId;

  @EnviedField(obfuscate: true, varName: 'ONE_SIGNAL_API_KEY')
  static String oneSignalApiKey = _Env.oneSignalApiKey;

  @EnviedField(obfuscate: true, varName: 'OZOW_SITE_CODE')
  static String ozowSiteCode = _Env.ozowSiteCode;

  @EnviedField(obfuscate: true, varName: 'OZOW_API_KEY')
  static String ozowApiKey = _Env.ozowApiKey;

  @EnviedField(obfuscate: true, varName: 'OZOW_API_PRIVATE_KEY')
  static String ozowApiPrivateKey = _Env.ozowApiPrivateKey;
}
