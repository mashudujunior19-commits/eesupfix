import 'package:flutter_animate/flutter_animate.dart';

extension SlideInAnimationExt on Animate {
  Animate slideIn(double delay) {
    final validDelay = delay > 700 ? 300 : delay;
    // return fadeIn(delay: (validDelay + 100).ms).slide(
    //   delay: validDelay.ms,
    //   begin: const Offset(.5, .2),
    //   end: const Offset(0, 0),
    //   duration: 500.ms,
    //   curve: Curves.easeInOutCubic,
    // );

    return fadeIn(delay: validDelay.ms);
  }
}


