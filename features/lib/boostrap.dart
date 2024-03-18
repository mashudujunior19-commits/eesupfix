import 'dart:async';

import 'package:features/app.dart';
import 'package:features/config.dart';
import 'package:features/core/env/flavor_type.dart';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> bootstrap({required Flavor environment,required ThemeData theme}) async {
  final config = AppConfig(environment: environment);
  await config.loadEnv();
  await config.intitializeServices();
  config.registerInstances();

  final env = environment.type;

  if (env == FlavorType.development || env == FlavorType.test) {
    runApp(MainApp(theme:  theme));
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

      runApp(MainApp(theme: theme,));
    }, (error, stackTrace) {
      if (kDebugMode) {
        print('Error #########################: $error ');
      }
    });
  }
}
