import 'dart:async';

import 'package:eesup/app.dart';
import 'package:eesup/config.dart';
import 'package:eesup/src/env/environment_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> bootstrap({required EnvironmentType env}) async {
  final config = AppConfig(env: env);
  await config.loadEnv();
  await config.intitializeServices();
  config.registerInstances();

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
