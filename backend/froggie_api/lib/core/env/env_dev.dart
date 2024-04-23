import 'package:envied/envied.dart';
part 'env_dev.g.dart';

@Envied(path: '.env.dev')
abstract class EnvDev{
  @EnviedField(obfuscate: true, varName: 'SUPABASE_URL')
  static String supabaseUrl = _EnvDev.supabaseUrl;

  @EnviedField(obfuscate: true, varName: 'SUPABASE_SERVICE_KEY')
  static String supabaseServiceKey = _EnvDev.supabaseServiceKey;

  @EnviedField(obfuscate: true, varName: 'ONE_SIGNAL_APP_ID')
  static String oneSignalAppId = _EnvDev.oneSignalAppId;

  @EnviedField(obfuscate: true, varName: 'ONE_SIGNAL_API_KEY')
  static String oneSignalApiKey = _EnvDev.oneSignalApiKey;

  @EnviedField(obfuscate: true, varName: 'OZOW_SITE_CODE')
  static String ozowSiteCode = _EnvDev.ozowSiteCode;

  @EnviedField(obfuscate: true, varName: 'OZOW_API_KEY')
  static String ozowApiKey = _EnvDev.ozowApiKey;

  @EnviedField(obfuscate: true, varName: 'OZOW_API_PRIVATE_KEY')
  static String ozowApiPrivateKey = _EnvDev.ozowApiPrivateKey;
}
