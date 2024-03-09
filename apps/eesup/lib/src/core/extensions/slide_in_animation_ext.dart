import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension SlideInAnimationExt on Animate {
  Animate slideIn(double delay) {
    return fadeIn(delay: (delay + 100).ms).slide(
      delay: delay.ms,
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
      duration: 600.ms,
      curve: Curves.easeInOutCubic,
    );
  }
}