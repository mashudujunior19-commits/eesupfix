import 'package:eesup/src/env/environment_type.dart';
import 'package:eesup_data_source/auth/data_source/auth_supabase_data_source.dart';
import 'package:eesup_repository/auth/auth_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppConfig {
  final EnvironmentType env;

  AppConfig({required this.env});

  ///Load the appropriate env file based on the app and env
  ///
  Future<void> loadEnv() async {
    if (env == EnvironmentType.development || env == EnvironmentType.test) {
      await dotenv.load(fileName: ".dev.env");
    } else if (env == EnvironmentType.development) {
      await dotenv.load(fileName: ".eesup.env");
    }
  }

  Future<void> intitializeServices() async {
    await Firebase.initializeApp();

    // Initialize Supabase
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? '',
      anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
      authOptions: FlutterAuthClientOptions(
        localStorage:
            env == EnvironmentType.test ? const EmptyLocalStorage() : null,
      ),
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

    final authRepo = AuthRepository(
      supaSource: AuthSupabaseDataSource(client: supabaseClient),
    );
    if (!getIt.isRegistered(instance: authRepo)) {
      getIt.registerSingleton<AuthRepository>(authRepo);
    }
  }

  void setUpSentry(FlutterErrorDetails details) {
    if (env != 'dev') {
      Sentry.captureException(details.exception, stackTrace: details.stack);
    }
  }
}
