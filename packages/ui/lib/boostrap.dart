import 'dart:async';
import 'package:ui/app.dart';
import 'package:ui/config.dart';
import 'package:ui/src/core/env/flavor_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> bootstrap({required Flavor environment}) async {
  WidgetsFlutterBinding.ensureInitialized();
  final config = AppConfig(environment: environment);
  await config.loadEnv();
  await config.intitializeServices();
  config.registerInstances();

  final env = environment.type;

  if (env == FlavorType.development || env == FlavorType.test) {
    runApp(MainApp());
  } else {
    FlutterError.onError = (details) {
      if (kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      } else {
        config.setUpSentry(details);
      }
    };
    runApp(MainApp());
  }
}
