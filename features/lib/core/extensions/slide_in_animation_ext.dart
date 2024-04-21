import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension SlideInAnimationExt on Animate {
  Animate slideIn(double delay) {
    final validDelay = delay > 700 ? 300 : delay;
    return fadeIn(delay: (validDelay + 100).ms).slide(
      delay: validDelay.ms,
      begin: const Offset(.5, .5),
      end: const Offset(0, 0),
      duration: 300.ms,
      curve: Curves.easeInOutCubic,
    );
  }
}
