import 'package:flutter/material.dart';

/// Screen-width breakpoints used to adapt layouts between phones and
/// larger screens (tablets, foldables, desktop web).
class Breakpoints {
  Breakpoints._();

  static const double tablet = 600;
  static const double desktop = 1024;
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  bool get isTablet => screenWidth >= Breakpoints.tablet;

  bool get isDesktop => screenWidth >= Breakpoints.desktop;

  /// Picks a value based on the current screen width, falling back to
  /// [phone] when a larger breakpoint's value isn't provided.
  T responsive<T>({required T phone, T? tablet, T? desktop}) {
    final width = screenWidth;
    if (width >= Breakpoints.desktop && desktop != null) return desktop;
    if (width >= Breakpoints.tablet && tablet != null) return tablet;
    return phone;
  }

  /// Grid column count that scales with screen width, e.g. for product grids.
  int gridColumns({int phone = 2, int tablet = 3, int desktop = 4}) {
    return responsive(phone: phone, tablet: tablet, desktop: desktop);
  }
}
