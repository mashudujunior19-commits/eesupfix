import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/notifications/ui/screens/notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const _Button(count: 20);
  }
}

class _Button extends StatelessWidget {
  const _Button({this.count = 0});
  final int count;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        notificationDialog(context);
      },
      icon: Badge(
        alignment: Alignment.topRight,
        isLabelVisible: count > 0,
        label: Text(
          count.toString(),
          style: context.textTheme.labelSmall?.copyWith(
            color: Colors.white,
            fontSize: 11,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(3.0),
          child: Icon(
            IconlyLight.notification,
            size: 21,
          ),
        ),
      ).animate().shake(duration: 1.seconds),
    );
  }
}
