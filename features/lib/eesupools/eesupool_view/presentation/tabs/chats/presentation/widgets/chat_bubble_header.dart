import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data_sources/eesupools/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ChatBubbleHeader extends StatelessWidget {
  const ChatBubbleHeader({
    super.key,
    required this.message,
    this.onReply,
    required this.showOptions,
  });
  final ChatMessage message;
  final bool showOptions;
  final void Function(ChatMessage message)? onReply;

  bool showDelete(String? sessionId) {
    if (message.isDeleted == true) {
      return false;
    }

    if (message.authorId == sessionId) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme.displayMedium;
    final memberId = '';
    final isMe = (memberId == message.authorId);
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe)
            Text(
              isMe ? 'Me' : message.authorName!,
              style: textTheme!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
          if (showOptions)
            PopupMenuButton(
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Image.asset(
                  'assets/images/more.png',
                  width: 20,
                  color: Colors.black,
                ),
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'reply',
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          BootstrapIcons.reply_all,
                          color: Colors.black,
                          size: 16,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Reply',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (showDelete(memberId))
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          const Icon(
                            IconlyLight.delete,
                            color: Colors.black,
                            size: 13,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Delete',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (!isMe)
                    PopupMenuItem(
                      value: 'Report',
                      child: Row(
                        children: [
                          const Icon(
                            BootstrapIcons.flag,
                            color: Colors.black,
                            size: 12,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Report',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                ];
              },
              onSelected: (value) {
                switch (value) {
                  case 'reply':
                    // ref.read(chatTextFieldProvider).setReplyMessage(message);
                    // onReply?.call(message);
                    break;
                  case 'delete':
                    //  deleteMessage(isMe, ref, context);
                    break;
                  case 'Report':
                    // showCreateIssueDialog(context, message: message);
                    break;
                }
              },
            )
        ],
      ),
    );
  }

  Future<void> deleteMessage(bool isMe, BuildContext context) async {
    // if (isMe) {
    //   final result =
    //       await ref.read(eesupoolRepoProvider).deleteChatMessage(message.id);
    //   result.fold((l) {
    //     showSnackBar(context: context, message: l.message);
    //   }, (r) => null);
    // } else {
    //   final result = await ref
    //       .read(eesupoolRepoProvider)
    //       .softDeleteChatMessage(message.id);
    //   result.fold((l) {
    //     showSnackBar(context: context, message: l.message);
    //   }, (r) => null);
    // }
  }
}
