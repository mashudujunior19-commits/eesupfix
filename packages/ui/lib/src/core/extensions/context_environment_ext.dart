import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ui/config.dart';

extension ContextEnvironmentExt on BuildContext {
  /// Returns the environment of the app
  Flavor get environment => GetIt.I<Flavor>();
}
