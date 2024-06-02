import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/eesupools/models/eesupool_issue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/utils/date_formatter.dart';
import 'package:ui/src/views/eesupools/ui/tabs/chats/ui/widgets/message_bubble.dart';
import 'package:ui/src/views/eesupools/ui/tabs/members/ui/member_settings.dart';

@RoutePage()
class IssueViewScreen extends StatefulWidget {
  const IssueViewScreen({super.key, required this.pool, required this.issue});
  final EESUpool pool;
  final EESUpoolIssue issue;

  @override
  State<IssueViewScreen> createState() => _IssueViewScreenState();
}

class _IssueViewScreenState extends State<IssueViewScreen> {
  late EESUpoolIssue issue;
  @override
  void initState() {
    super.initState();
    issue = widget.issue;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text('Issue review'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 300),
          children: [
            if (issue.reporter != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Reported by', style: context.textTheme.labelMedium),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: context.colorScheme.onSurface.withOpacity(.2),
                          width: .5,
                        ),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      leading: CircleAvatar(
                        backgroundColor:
                            context.colorScheme.tertiary.withOpacity(.5),
                        child: Text(issue.reporter?.fullName[0] ?? '~'),
                      ),
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(issue.reporter?.fullName ?? '~'),
                          const SizedBox(width: 10),
                          if (issue.reporter?.isCensored ?? false)
                            const Tooltip(
                              message: 'Restricted',
                              child: Icon(
                                BootstrapIcons.shield_lock,
                                color: Colors.red,
                                size: 13,
                              ),
                            ),
                        ],
                      ),
                      subtitle: Text(
                        issue.reporter?.role.toString() ?? '~',
                        style: context.textTheme.labelSmall!.copyWith(
                          color: context.colorScheme.secondary,
                          fontSize: 11,
                        ),
                      ),
                      trailing: Builder(builder: (context) {
                        return IconButton(
                          icon: const Icon(IconlyLight.setting),
                          onPressed: () {
                            context.showBottomSheetDialog(
                              child: MemberSettingsDialog(
                                pool: widget.pool,
                                selectedMember: issue.reporter!,
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ),
                ],
              ),
            if (issue.offender != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Text('Offender', style: context.textTheme.labelMedium),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: context.colorScheme.onSurface.withOpacity(.2),
                          width: .5,
                        ),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      leading: CircleAvatar(
                        backgroundColor:
                            context.colorScheme.tertiary.withOpacity(.5),
                        child: Text(issue.offender?.fullName[0] ?? '~'),
                      ),
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(issue.offender?.fullName ?? '~'),
                          const SizedBox(width: 10),
                          if (issue.offender?.isCensored ?? false)
                            const Tooltip(
                              message: 'Restricted',
                              child: Icon(
                                BootstrapIcons.shield_lock,
                                color: Colors.red,
                                size: 13,
                              ),
                            ),
                        ],
                      ),
                      subtitle: Text(
                        issue.offender?.role.toString() ?? '~',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.secondary,
                          fontSize: 11,
                        ),
                      ),
                      trailing: Builder(builder: (context) {
                        return IconButton(
                          icon: const Icon(IconlyLight.setting),
                          onPressed: () {
                            context.showBottomSheetDialog(
                              child: MemberSettingsDialog(
                                pool: widget.pool,
                                selectedMember: issue.offender!,
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 15),
            Text('Description', style: context.textTheme.labelMedium),
            const SizedBox(height: 5),
            Text(issue.description, style: context.textTheme.bodySmall),
            if (issue.chatMessage != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: Colors.grey.shade400, thickness: .5),
                  Text('Message reported',
                      style: context.textTheme.labelMedium),
                  MessageBubble(
                    message: issue.chatMessage!,
                    pool: widget.pool,
                  ),
                ],
              ),
            const SizedBox(height: 10),
            Row(
              children: List.generate(
                issue.attachments?.length ?? 0,
                (index) {
                  final media = issue.attachments![index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        media.url,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(color: Colors.grey.shade400, thickness: .5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Created at', style: context.textTheme.labelMedium),
                Text(DateFormatter.yetAnotherDateFormat(issue.createdAt)),
              ],
            ),
            Divider(color: Colors.grey.shade400, thickness: .5),
            ListTile(
              contentPadding: const EdgeInsets.only(top: 0),
              title: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(IconlyLight.shieldDone, color: Colors.black, size: 17),
                  SizedBox(width: 10),
                  Text('Mark as resolved'),
                ],
              ),
              subtitle: Text(
                'Mark this issue as resolved, this action cannot be undone.',
                style: context.textTheme.bodySmall!.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              trailing: SizedBox(
                width: 60,
                height: 30,
                child: Transform.scale(
                  scale: 0.93,
                  child: Switch(
                    value: issue.resolvedAt != null,
                    onChanged: (value) {
                      //setMarkAsResolved(value);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
