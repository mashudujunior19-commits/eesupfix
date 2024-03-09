import 'package:flutter/material.dart';

extension ContextThemeExt on BuildContext {
  //media query extensions
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;

  //theme extensions
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
