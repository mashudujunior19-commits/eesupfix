import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:eesup_data_source/eesupools/models/eesupool_member.dart';
import 'package:eesup_mobile/src/features/eesupools/presentation/providers/chat_text_field_notifier.dart';
import 'package:eesup_mobile/src/features/eesupools/presentation/providers/eeupool_view_notifier.dart';
import 'package:eesup_mobile/src/features/eesupools/presentation/chats/add_topics_dialog.dart';
import 'package:eesup_mobile/src/features/eesupools/presentation/chats/review_messages.dart';
import 'package:eesup_mobile/src/features/eesupools/presentation/chats/suggest_hash_tag_bottom_sheet.dart';
import 'package:eesup_mobile/src/features/eesupools/presentation/issues/create_issue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TextFieldOptionsPopUp extends ConsumerWidget {
  const TextFieldOptionsPopUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme.bodySmall;
    final pool = ref.watch(eesupoolViewProvider);
    return PopupMenuButton(
      position: PopupMenuPosition.over,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
        child: Icon(
          Icons.add,
          color: Colors.black.withOpacity(.6),
        ),
      ),
      itemBuilder: (context) {
        return [
          if (pool?.role == EESUpoolMemberRole.admin)
            PopupMenuItem(
              onTap: () {
                ref.read(chatTextFieldProvider.notifier).pickFiles();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    IconlyLight.image2,
                    color: Colors.black,
                    size: 15,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Add files',
                    style: textTheme!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          if (pool?.role == EESUpoolMemberRole.admin)
            PopupMenuItem(
              onTap: () {
                context.push(ReviewPoolMessages.route);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    IconlyLight.message,
                    color: Colors.black.withOpacity(.7),
                    size: 15,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Review messages',
                    style: textTheme?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          if (pool?.role == EESUpoolMemberRole.admin)
            PopupMenuItem(
              onTap: () {
                showAddEESUpoolEventDialog(context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    BootstrapIcons.hash,
                    color: Colors.black.withOpacity(.7),
                    size: 15,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Add & Review topics',
                    style: textTheme?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          PopupMenuItem(
            onTap: () {
              showSuggestHashTagSheet(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  BootstrapIcons.hash,
                  color: Colors.black.withOpacity(.7),
                  size: 15,
                ),
                const SizedBox(width: 10),
                Text(
                  'Suggest a topic',
                  style: textTheme?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            onTap: () {
              showCreateIssueDialog(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  BootstrapIcons.flag,
                  color: Colors.black,
                  size: 15,
                ),
                const SizedBox(width: 10),
                Text(
                  'Report',
                  style: textTheme?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            onTap: () {},
            child: Text(
              'Cancel',
              style: textTheme?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ];
      },
    );
  }
}
