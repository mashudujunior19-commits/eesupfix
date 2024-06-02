import 'package:dart_frog/dart_frog.dart';
import 'package:eesup_dart_frog/core/env/env_service.dart';
import 'package:eesup_dart_frog/core/env/env_type.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase/supabase.dart';

Handler middleware(Handler handler) {
  return (context) async {

    ///register supabase client
    final getIt = GetIt.I;
    if (!getIt.isRegistered<EnvService>()) {
      getIt.registerSingleton(const EnvService(EnvType.production));
    }
    final env = getIt.get<EnvService>();
    if (!getIt.isRegistered<SupabaseClient>()) {
      getIt.registerSingleton(
        SupabaseClient(env.supabaseUrl, env.supabaseServiceKey),
      );
    }
    // Forward the request to the respective handler.
    final response = await handler(context);
    // Return a response.
    return response;
  };
}
