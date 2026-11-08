// ignore_for_file: use_build_context_synchronously

import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/utils/date_formatter.dart';
import 'package:ui/src/views/role_assignments/ui/role_assigned_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:data/notifications/models/notification.dart' as not;

import '../bloc/notifications_bloc.dart';

class NotificationTile extends StatelessWidget {
  NotificationTile({
    super.key,
    required this.notification,
    this.isNew = false,
  });
  final not.Notification notification;

  /// Unseen when the list was opened; highlighted for this visit.
  final bool isNew;

  final _controller = ExpandedTileController(isExpanded: true);

  /// Whether an invite / join request notification has already been answered.
  bool get _resolved => notification.data?.response != null;

  Future<void> _respond(BuildContext context, String status) async {
    final poolId = notification.data?.eesupoolId;
    final userId = notification.data?.userId;
    if (poolId == null || userId == null) return;

    final bloc = context.read<NotificationsBloc>();
    final repo = context.read<EESUpoolRepository>();
    context.loaderOverlay.show();
    try {
      // The database only accepts this while the request is still pending and
      // the caller is allowed to answer it; otherwise it says why.
      final results = await repo.updateEESUpoolRequest(userId, poolId, status);
      if (!context.mounted) return;
      results.fold(
        (l) => context.snackBarError(l.message),
        (_) => bloc.add(NotificationRespondedEvent(notification.id, status)),
      );
    } finally {
      if (context.mounted) context.loaderOverlay.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: _resolved ? Colors.grey.shade200 : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isNew
              ? context.colorScheme.primary.withOpacity(.6)
              : Colors.grey.withOpacity(.2),
          width: 1,
        ),
      ),
      child: ExpandedTile(
        theme: ExpandedTileThemeData(
          headerColor: _resolved ? Colors.grey.shade200 : Colors.white,
          //   headerRadius: 0.0,
          headerPadding:
              const EdgeInsets.only(left: 0, right: 5, bottom: 5.0, top: 5),
          headerSplashColor: Colors.white,
          contentBackgroundColor:
              _resolved ? Colors.grey.shade200 : Colors.white,
          contentPadding: EdgeInsets.zero,
          //contentRadius: 12.0,
        ),
        trailing: const Icon(IconlyLight.arrowRight2, size: 17),
        controller: _controller,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(IconlyLight.message, size: 20),
            ),
            10.sW,
            // Expanded so a long title wraps instead of overflowing the row
            // (it sits beside the chevron).
            Expanded(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  notification.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: isNew
                      ? const TextStyle(fontWeight: FontWeight.bold)
                      : (_resolved ? const TextStyle(color: Colors.grey) : null),
                ),
                1.sH,
                Text(
                  '🕘 ${DateFormatter.formatDateToNamedayWithTime2(notification.createdAt)}',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: Colors.grey.withOpacity(.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            ),
          ],
        ),
        content: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(thickness: .5),
              Text(
                notification.body ?? '',
                style: context.textTheme.displaySmall?.copyWith(
                  fontSize: 13.5,
                ),
              ),
              if (notification.type == not.NotificationType.roleAssigned &&
                  notification.data?.eesupoolOrderId != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InkWell(
                    onTap: () => openRoleChecklist(context, notification),
                    child: const Text('Open checklist'),
                  ),
                ),
              if (notification.data != null &&
                  (notification.type == not.NotificationType.eesupoolInvite ||
                      notification.type ==
                          not.NotificationType.eesupoolRequest))
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: _resolved
                      // Decided: no buttons, just the outcome. It is final.
                      ? Text(
                          notification.data!.response!,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Row(
                          children: [
                            InkWell(
                              onTap: () => _respond(context, 'Accepted'),
                              child: Text(notification.type ==
                                      not.NotificationType.eesupoolInvite
                                  ? 'Join'
                                  : 'Accept'),
                            ),
                            25.sW,
                            InkWell(
                              onTap: () => _respond(context, 'Declined'),
                              child: Text(
                                'Decline',
                                style: context.textTheme.labelMedium?.copyWith(
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                )
            ],
          ),
        ),
        onTap: () {
          debugPrint("tapped!!");
        },
        onLongTap: () {
          debugPrint("long tapped!!");
        },
      ),
    );
  }
}
