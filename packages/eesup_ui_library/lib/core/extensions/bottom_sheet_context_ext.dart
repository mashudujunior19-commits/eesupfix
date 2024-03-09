import 'package:eesup_ui_library/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

extension BottomSheetExt on BuildContext {
  Future<Object?> showAddEESUpoolEventDialog(
    BuildContext context,
    Widget child,
  ) {
    return showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            margin: EdgeInsets.only(
              top: context.height * .1,
            ),
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Scaffold(body: child),
          ),
        );
      },
      animationType: DialogTransitionType.slideFromBottomFade,
      curve: Curves.easeIn,
      duration: 400.ms,
    );
  }
}
