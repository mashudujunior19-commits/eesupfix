import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:ui/core/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:data/notifications/models/notification.dart' as not;

class NotificationTile extends StatelessWidget {
  NotificationTile({super.key, required this.notification});
  final not.Notification notification;

  final _controller = ExpandedTileController(isExpanded: true);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.withOpacity(.2),
          width: 1,
        ),
      ),
      child: ExpandedTile(
        theme: const ExpandedTileThemeData(
          headerColor: Colors.white,
          headerRadius: 0.0,
          headerPadding:
              EdgeInsets.only(left: 0, right: 5, bottom: 5.0, top: 5),
          headerSplashColor: Colors.white,
          contentBackgroundColor: Colors.white,
          contentPadding: EdgeInsets.zero,
          contentRadius: 12.0,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(notification.title),
                1.sH,
                Text(
                  '🕘 ${DateFormatter.formatDateToNamedayWithTime2(notification.createdAt)}',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: Colors.grey.withOpacity(.8),
                    fontSize: 12,
                  ),
                ),
              ],
            )
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
              if (notification.data != null &&
                  notification.type == not.NotificationType.eesupoolInvite)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          // context.loaderOverlay.show();
                          // final poolId = notification.data?.eesupoolId;
                          // final userId = notification.data?.userId;
                          // if (poolId == null || userId == null) return;
                          // final results = await ref
                          //     .read(eesupoolRepoProvider)
                          //     .updateEESUpoolRequest(
                          //         userId, poolId, 'Accepted');

                          // results.fold(
                          //   (l) => debugPrint(l.toString()),
                          //   (r) {
                          //     ref
                          //         .read(notificationRepoProvider)
                          //         .deleteNotification(notification.id);
                          //   },
                          // );
                          // context.loaderOverlay.hide();
                        },
                        child: const Text('Join'),
                      ),
                      25.sW,
                      InkWell(
                        onTap: () async {
                          // context.loaderOverlay.show();
                          // final poolId = notification.data?.eesupoolId;
                          // final userId = notification.data?.userId;
                          // if (poolId == null || userId == null) return;
                          // final results = await ref
                          //     .read(eesupoolRepoProvider)
                          //     .updateEESUpoolRequest(
                          //         userId, poolId, 'Declined');

                          // results.fold(
                          //   (l) => debugPrint(l.toString()),
                          //   (r) {
                          //     ref
                          //         .read(notificationRepoProvider)
                          //         .deleteNotification(notification.id);
                          //   },
                          // );
                          // context.loaderOverlay.hide();
                        },
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
