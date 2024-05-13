import 'package:ui/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';

class BackgroundDecoration extends StatelessWidget {
  const BackgroundDecoration({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      width: context.width,
      decoration: context.bgImage,
      child: Container(
        width: context.width,
        height: context.height,
        margin: const EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.67),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(.2),
              blurRadius: 30,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
