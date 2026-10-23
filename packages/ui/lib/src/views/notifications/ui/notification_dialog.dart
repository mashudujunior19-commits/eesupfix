import 'package:data/utils/eesup_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/views/notifications/bloc/notifications_bloc.dart';
import 'package:ui/src/views/notifications/ui/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NotificationsDialog extends StatefulWidget {
  const NotificationsDialog({super.key});

  @override
  State<NotificationsDialog> createState() => _NotificationsDialogState();
}

class _NotificationsDialogState extends State<NotificationsDialog> {
  /// Ids that were unseen when the list was opened. They keep their "new"
  /// styling for this visit even though they are flagged seen straight away.
  final Set<int> _newlySeen = {};
  final Set<int> _requested = {};

  void _markSeen(List<dynamic> notifications) {
    final unseen = [
      for (final n in notifications)
        if (n.seenAt == null && !_requested.contains(n.id)) n.id as int
    ];
    if (unseen.isEmpty) return;
    _requested.addAll(unseen);
    _newlySeen.addAll(unseen);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<NotificationsBloc>().add(MarkNotificationsSeenEvent(unseen));
    });
  }

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
              _markSeen(notifications);

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
                    isNew: _newlySeen.contains(notifications[index].id),
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
