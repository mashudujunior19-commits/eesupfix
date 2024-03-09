import 'package:eesup/src/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';



///Shows a busy indicator
///
///Example:
///```dart
///LoadingIndicator(
///  color: Colors.red,
/// size: 30,
/// topMargin: 0,
/// )
/// ```
class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({
    super.key,
    this.color,
    this.size = 30,
    this.topMargin = 0,
  });
  final Color? color;
  final double size;
  final double topMargin;

  @override
  Widget build(BuildContext context) {
 
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: topMargin),
        child: LoadingAnimationWidget.discreteCircle(
          color: color ?? context.colorScheme.primary,
          secondRingColor: Colors.red,
          thirdRingColor: Colors.blue,
          size: 30,
        ),
      ),
    );
  }
}

