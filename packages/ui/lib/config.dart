import 'package:ui/src/core/env/app_type.dart';
import 'package:ui/src/core/env/flavor_type.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppConfig {
  final Flavor environment;

  AppConfig({required this.environment});

  ///Load the appropriate env file based on the app and env
  ///
  Future<void> loadEnv() async {
    final env = environment.type;
    if (env == FlavorType.development || env == FlavorType.test) {
      await dotenv.load(fileName: ".dev.env");
    } else if (env == FlavorType.development) {
      await dotenv.load(fileName: ".env");
    }
  }

  Future<void> intitializeServices() async {
    //final env = environment.type;
    await Firebase.initializeApp();

    // Initialize Supabase
    await Supabase.initialize(
        url: dotenv.env['SUPABASE_URL'] ?? '',
        anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
        debug: false,
        realtimeClientOptions:
            const RealtimeClientOptions(logLevel: RealtimeLogLevel.debug)

        // authOptions: FlutterAuthClientOptions(
        //   localStorage:
        //       env == FlavorType.test ? const EmptyLocalStorage() : null,
        // ),
        );

    //init one signal
    OneSignal.initialize(dotenv.env['ONESIGNAL_APP_ID'] ?? '');
  }

  void registerInstances() {
    final getIt = GetIt.I;
    final supabaseClient = Supabase.instance.client;

    if (!getIt.isRegistered(instance: SupabaseClient)) {
      getIt.registerSingleton<SupabaseClient>(supabaseClient);
    }

    if (!getIt.isRegistered(instance: Flavor)) {
      getIt.registerSingleton<Flavor>(environment);
    }
  }

  void setUpSentry(FlutterErrorDetails details) {
    final env = environment.type;
    if (env != FlavorType.production) {
      Sentry.captureException(details.exception, stackTrace: details.stack);
    }
  }
}

class Flavor {
  final FlavorType type;
  final AppType app;
  Flavor({required this.type, required this.app});
}
