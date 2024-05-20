import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/eesupools/models/chat_message.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:flutter_highlighted_text/flutter_highlighted_text.dart';
import 'package:ui/src/core/extensions/bottom_sheet_context_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/features/eesupools/ui/tabs/chats/ui/chat_text_field/bloc/chat_textfield_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ui/src/features/eesupools/ui/tabs/chats/ui/widgets/message_reaction.dart';
import 'package:ui/src/features/eesupools/ui/tabs/chats/ui/widgets/reply_preview.dart';
import 'package:ui/src/features/eesupools/ui/tabs/issues/ui/create_issue_dialog.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.pool,
  });
  final EESUpool pool;
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    bool isReply = pool.memberId != message.authorId;

    return VisibilityDetector(
      //The visibility detector is used to update the seen of
      //a message
      onVisibilityChanged: (visibilityInfo) {
        // final visibleP = visibilityInfo.visibleFraction * 100;
        // if (visibleP >= 90.00) {
        //   print('visibility met');
        //   print(pool.memberId);
        //   print(message.messageSeens);
        //   print(message.messageSeens.contains(pool.memberId));
        //   //  if (message.messageSeens.contains(pool.memberId) == false) {
        //   print('visibility contains');
        //   context
        //       .read<ChatBloc>()
        //       .add(MessageSeenUpdated(message.id, pool.memberId!));
        //   //}
        // }
      },
      key: Key(message.id.toString()),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment:
              isReply ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * 0.2,
                maxWidth: MediaQuery.of(context).size.width * 0.68,
              ),
              decoration: BoxDecoration(
                color: !isReply
                    ? Colors.blue.shade50
                    : Colors.white.withOpacity(.6),
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: isReply ? _replyRadius() : _radius(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ReplyPreview(pool: pool, tags: [], reply: message.reply),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(message.authorName ?? ''),
                        PopupMenuButton(
                          child: const Icon(Icons.more_horiz_outlined),
                          itemBuilder: (context) {
                            return [
                              _bubblPopUpOption(
                                context,
                                'Reply',
                                BootstrapIcons.reply_all,
                                () {
                                  context.read<ChatTextFieldBloc>().add(
                                        ChatMessageReplyToAdded(message),
                                      );
                                },
                              ),
                              if (message.authorId != pool.memberId)
                                _bubblPopUpOption(
                                  context,
                                  'Report',
                                  BootstrapIcons.flag,
                                  () {
                                    context.showBottomSheetDialog(
                                      child: CreateIssueDialog(
                                          message: message, pool: pool),
                                    );
                                  },
                                ),
                              _bubblPopUpOption(
                                context,
                                'Delete',
                                IconlyLight.delete,
                                () {},
                              ),
                            ];
                          },
                        )
                      ],
                    ),
                  ),
                  if (message.content != null)
                    _MessageText(
                      message: message,
                      pool: pool,
                      isReply: isReply,
                    ),
                  MessageReaction(pool: pool, message: message),
                ],
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: (100).ms),
    );
  }

  PopupMenuItem<String> _bubblPopUpOption(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onTap,
  ) {
    return PopupMenuItem(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.black, size: 16),
          10.sW,
          Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  BorderRadius _replyRadius() {
    return const BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
      bottomRight: Radius.circular(25),
    );
  }

  BorderRadius _radius() {
    return const BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
      bottomLeft: Radius.circular(25),
    );
  }
}

class _MessageText extends StatelessWidget {
  const _MessageText({
    required this.message,
    required this.pool,
    required this.isReply,
  });

  final ChatMessage message;
  final EESUpool pool;
  final bool isReply;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
      ),
      child: HighlightedText(
        message.content!,
        patterns: [...pool.chatTags ?? []],
        textAlign: !isReply ? TextAlign.start : TextAlign.end,
        style: context.textTheme.bodySmall?.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        highLightStyle: context.textTheme.bodySmall?.copyWith(
          color: Colors.blue,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
          fontSize: 16,
        ),
      ),
    );
  }
}
