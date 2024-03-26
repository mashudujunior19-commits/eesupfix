import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedReactionButton extends StatefulWidget {
  const AnimatedReactionButton({
    super.key,
    required this.child,
    required this.onTap,
  });
  final Widget child;
  final void Function() onTap;

  @override
  State<AnimatedReactionButton> createState() => _AnimatedReactionButtonState();
}

class _AnimatedReactionButtonState extends State<AnimatedReactionButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(0),
        ),
      ),
      onPressed: () {
        widget.onTap();
        _controller.forward(from: 0);
      },
      icon: widget.child
          .animate(
            autoPlay: false,
            controller: _controller,
          )
          .shake(
            duration: 1000.ms,
            rotation: .23,
            curve: Curves.easeInCubic,
          ),
    );
  }
}
