import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ui/src/features/notifications/bloc/notifications_bloc.dart';
import 'package:ui/src/features/notifications/ui/notification_dialog.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.showBottomSheetDialog(child: const NotificationsDialog());
      },
      icon: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsStreaming) {
            return Badge(
              backgroundColor: context.colorScheme.primary,
              alignment: Alignment.topRight,
              isLabelVisible: state.notifications.isNotEmpty,
              label: Text(
                state.notifications.length.toString(),
                style: context.textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: const Icon(
                  IconlyLight.notification,
                  size: 23,
                ).animate().shake(),
              ),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(3.0),
              child: Icon(
                IconlyLight.notification,
                size: 23,
              ),
            );
          }
        },
      ).animate().shake(duration: 1.seconds),
    );
  }
}
