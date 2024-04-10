import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class FullScreenMessageWidget extends StatelessWidget {
  const FullScreenMessageWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            IconlyLight.chat,
            color: context.colorScheme.primary.withOpacity(.7),
          ),
          5.sH,
          Text(
            message,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.primary.withOpacity(.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate().shakeX();
  }
}
