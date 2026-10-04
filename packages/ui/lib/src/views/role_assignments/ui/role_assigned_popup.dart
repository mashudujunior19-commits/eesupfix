import 'package:auto_route/auto_route.dart';
import 'package:data/notifications/models/notification.dart' as not;
import 'package:data/notifications/repository/notification_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/views/notifications/bloc/notifications_bloc.dart';

/// Opens the checklist a 'role_assigned' notification points at.
void openRoleChecklist(BuildContext context, not.Notification notification) {
  final poolOrderId = notification.data?.eesupoolOrderId;
  if (poolOrderId == null) return;
  context.router.push(
    RoleChecklistRoute(
      eesupoolOrderId: poolOrderId,
      orderId: notification.data?.orderId,
      title: notification.title,
    ),
  );
}

/// Pops up each new (unseen) role assignment once, with a shortcut to its
/// checklist, then marks it seen so it isn't shown again.
class RoleAssignedPopupListener extends StatefulWidget {
  const RoleAssignedPopupListener({super.key, required this.child});

  final Widget child;

  @override
  State<RoleAssignedPopupListener> createState() =>
      _RoleAssignedPopupListenerState();
}

class _RoleAssignedPopupListenerState extends State<RoleAssignedPopupListener> {
  final Set<int> _shown = {};
  bool _showing = false;

  @override
  void initState() {
    super.initState();
    // The notification stream starts at app launch, so it may already have
    // delivered before this screen was built.
    final state = context.read<NotificationsBloc>().state;
    if (state is NotificationsStreaming) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _showNext(state.notifications),
      );
    }
  }

  Future<void> _showNext(List<not.Notification> notifications) async {
    if (_showing) return;
    final pending = notifications
        .where((n) =>
            n.type == not.NotificationType.roleAssigned &&
            n.seenAt == null &&
            !_shown.contains(n.id))
        .toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    if (pending.isEmpty) return;

    final notification = pending.first;
    _shown.add(notification.id);
    _showing = true;
    context.read<NotificationRepo>().markSeen(notification.id);

    final open = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(notification.title),
        content: Text(notification.body ?? ''),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Later'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Open checklist'),
          ),
        ],
      ),
    );
    _showing = false;
    if (!mounted) return;
    if (open == true) openRoleChecklist(context, notification);
    _showNext(notifications);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationsBloc, NotificationsState>(
      listener: (context, state) {
        if (state is NotificationsStreaming) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => _showNext(state.notifications),
          );
        }
      },
      child: widget.child,
    );
  }
}
