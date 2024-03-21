

import 'package:data_sources/eesupools/models/chat_message.dart';
import 'package:data_sources/eesupools/models/chat_message_reaction.dart';
import 'package:features/eesupools/eesupool_view/presentation/tabs/chats/presentation/widgets/chat_bubble_header.dart';
import 'package:features/eesupools/eesupool_view/presentation/tabs/chats/presentation/widgets/chat_bubble_media_files.dart';
import 'package:features/eesupools/eesupool_view/presentation/tabs/chats/presentation/widgets/chat_reply_bubble.dart';
import 'package:features/eesupools/eesupool_view/presentation/tabs/chats/presentation/widgets/chat_rich_text.dart';
import 'package:flutter/material.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.tags,
    required this.isAdmin,
    this.margin,
    this.onReply,
    this.onReaction,
    this.showOptions = true,
  });
  final bool showOptions;
  final EdgeInsets? margin;
  final bool isAdmin;
  final ChatMessage message;
  final List<String> tags;
  final void Function(ChatMessage message)? onReply;
  final void Function()? onReaction;

  bool showMessage(String? sessionId) {
    if (isAdmin) {
      return true;
    }

    if (message.isApproved == true) {
      return true;
    }

    if (message.authorId == sessionId) {
      return true;
    }

    if (message.isDeleted == true) {
      return false;
    }

    return false;
  }



  @override
  Widget build(BuildContext context) {
    // final memberId = ref.watch(eesupoolViewProvider)?.memberId;
    // final isMe = (memberId == message.authorId);

    // ///check if the message is approved
    // ///if the message is not approved, it will not be shown
    // ///unless the author is the current user
    // if (!showMessage(ref.read(authRepoProvider).sessionId)) {
    //   return const SizedBox.shrink();
    // }

    ///use is me to determine if the message is a reply or not
    bool isReply = 1==1;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme.bodySmall;
    final reply = message.reply;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          isReply ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 3),
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width * 0.2,
            maxWidth: MediaQuery.of(context).size.width * 0.68,
          ),
          margin: margin ??
              EdgeInsets.only(
                top: 15,
                left: isReply ? 15 : 0,
                right: !isReply ? 15 : 0,
              ),
          decoration: BoxDecoration(
            color: !isReply
                ? Colors.blue.shade50.withOpacity(.65)
                : Colors.white.withOpacity(.6),
            border: Border.all(
              color: Colors.grey.shade300,
              width: .7,
            ),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(25),
              topRight: const Radius.circular(25),
              bottomLeft: isReply
                  ? const Radius.circular(0)
                  : const Radius.circular(25),
              bottomRight: !isReply
                  ? const Radius.circular(0)
                  : const Radius.circular(25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ChatReplyBubble(reply: reply, tags: tags),
              ChatBubbleHeader(
                  message: message, onReply: onReply, showOptions: showOptions),
              ChatMediaFiles(mediaFiles: message.media),
              ChatBubbleRichText(message: message.content, tags: tags),
              //ChatMessageReaction(message: message, onReaction: onReaction),
              if (message.isDeleted == true)
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  child: Text(
                    'Removed by Admin',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              _messageDate(textTheme, isReply)
            ],
          ),
        ),
      ],
    );
  }

  Row _messageDate(TextStyle? textTheme, bool isReply) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(left: 10, bottom: 5),
        //   child: Text(
        //     DateFormatter.yetAnotherDateFormat(
        //       message.createdAt,
        //     ),
        //     style: textTheme!.copyWith(
        //       color: Colors.grey.shade700,
        //       fontWeight: FontWeight.w500,
        //       fontSize: 13,
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(right: 10, bottom: 5),
        //   child: Text(
        //     DateFormatter.formatTime(
        //       message.createdAt,
        //     ),
        //     style: textTheme.copyWith(
        //       color: Colors.grey.shade700,
        //       fontWeight: FontWeight.w500,
        //       fontSize: 13,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
