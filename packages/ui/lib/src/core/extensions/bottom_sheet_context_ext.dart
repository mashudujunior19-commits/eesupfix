import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

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
        );
      },
      // animationType: DialogTransitionType.slideFromBottomFade,
      // curve: Curves.easeIn,
      // duration: 400.ms,
    );
  }
}
