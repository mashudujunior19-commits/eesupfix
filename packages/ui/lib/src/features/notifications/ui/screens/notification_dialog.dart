import 'package:data/notifications/models/notification.dart' as not;
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/features/notifications/ui/widgets/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NotificationsDialog extends StatelessWidget {
  const NotificationsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = <not.Notification>[];
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
          top: context.height * .05,
          bottom: 45,
          left: 10,
          right: 10,
        ),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            centerTitle: true,
            title: const Text('Notifications'),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: context.bgImage,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 15, right: 15),
              itemBuilder: (context, index) {
                return NotificationTile(
                  notification: notifications[index],
                ).animate().slideIn(50.00 * index);
              },
              itemCount: notifications.length,
            ),
          ),
        ),
      ),
    );
  }
}
