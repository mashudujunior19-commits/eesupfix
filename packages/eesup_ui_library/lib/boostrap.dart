import 'dart:async';

import 'package:eesup_ui_library/app.dart';
import 'package:eesup_ui_library/config.dart';

import 'package:eesup_ui_library/env/environment_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> bootstrap({required AppEnvironment environment}) async {
  final config = AppConfig( environment: environment);
  await config.loadEnv();
  await config.intitializeServices();
  config.registerInstances();

  final env = environment.type;

  if (env == EnvironmentType.development || env == EnvironmentType.test) {
    runApp(MainApp());
  } else {
    FlutterError.onError = (details) {
      if (kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      } else {
        config.setUpSentry(details);
      }
    };
    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();

      runApp(MainApp());
    }, (error, stackTrace) {
      if (kDebugMode) {
        print('Error #########################: $error ');
      }
    });
  }
}
