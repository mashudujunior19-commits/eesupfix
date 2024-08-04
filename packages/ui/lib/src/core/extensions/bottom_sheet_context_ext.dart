import 'dart:ui';

import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension CustomAnimatedDialogExt on BuildContext {
  Future<Object?> showBottomSheetDialog({
    required Widget child,
    BorderRadius? radius,
    EdgeInsets? margin,
    bool isDismissable = true,
  }) {
    return showPlatformDialog(
      context: this,
      // barrierDismissible: isDismissable,
      builder: (BuildContext context) {
        return SafeArea(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              margin: margin ?? EdgeInsets.only(top: context.height * .1),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: radius ??
                    const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
              ),
              child: Scaffold(body: child),
            ),
          ),
        ).animate().slideY(
              begin: height,
              end: 0,
              duration: 200.ms,
              curve: Curves.easeInToLinear,
            );
      },
    );
  }

  Future<Object?> showDialog({
    required Widget child,
    BorderRadius? radius,
    EdgeInsets? margin,
    bool isDismissable = true,
    Color color = Colors.white,
  }) {
    return showPlatformDialog(
      context: this,
      androidBarrierDismissible: isDismissable,
      builder: (BuildContext context) {
        return SafeArea(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              margin: margin ??
                  EdgeInsets.only(
                    top: height * .15,
                    bottom: height * .15,
                    right: 10,
                    left: 10,
                  ),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Scaffold(
                body: child,
                backgroundColor: color,
              ),
            ),
          ),
        ).animate().slideY(
              begin: height,
              end: 0,
              duration: 200.ms,
              curve: Curves.easeInToLinear,
            );
      },
    );
  }
}
