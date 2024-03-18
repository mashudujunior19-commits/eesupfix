import 'package:features/config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

extension ContextEnvironmentExt on BuildContext {
  /// Returns the environment of the app
  AppEnvironment get environment => GetIt.I<AppEnvironment>();
}
