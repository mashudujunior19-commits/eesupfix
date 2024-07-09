import 'package:data/utils/eesup_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/views/notifications/bloc/notifications_bloc.dart';
import 'package:ui/src/views/notifications/ui/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NotificationsDialog extends StatelessWidget {
  const NotificationsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: const Text('Notifications'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: context.bgImage,
        child: BlocBuilder<NotificationsBloc, NotificationsState>(
          builder: (context, state) {
            if (state is NotificationsStreaming) {
              final notifications = state.notifications;
              if (notifications.isEmpty) {
                return FullScreenError(
                  isError: false,
                  exception: EESUpException(
                    message: 'You don\'t have new notifications.',
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.only(left: 15, right: 15),
                itemBuilder: (context, index) {
                  return NotificationTile(
                    notification: notifications[index],
                  ).animate().slideIn(50.00 * index);
                },
                itemCount: notifications.length,
              );
            } else if (state is NotificationsInitial) {
              return FullScreenError(
                isError: false,
                exception: EESUpException(
                  message: 'You don\'t have new notifications.',
                ),
              );
            } else if (state is NotificationsError) {
              return FullScreenError(exception: state.err);
            } else {
              return FullScreenError(
                exception: EESUpException(
                  message: 'You don\'t have new notifications.',
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
