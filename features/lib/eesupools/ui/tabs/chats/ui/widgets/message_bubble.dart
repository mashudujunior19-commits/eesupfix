import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data_sources/eesupools/models/chat_message.dart';
import 'package:data_sources/eesupools/models/eesupool.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/eesupools/ui/tabs/chats/ui/chat_text_field/bloc/chat_textfield_bloc.dart';
import 'package:features/eesupools/ui/tabs/chats/ui/widgets/message_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

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

    return Padding(
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
              color:
                  !isReply ? Colors.blue.shade50 : Colors.white.withOpacity(.6),
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: isReply ? _replyRadius() : _radius(),
            ),
            child: Column(
              crossAxisAlignment:
                  !isReply ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                10.sH,
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
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
                            _bubblPopUpOption(
                              context,
                              'Report',
                              BootstrapIcons.flag,
                              () {},
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
                MessageRichText(
                  message: message.content,
                  tags: const ["#cycling"],
                ),
                10.sH,
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (100).ms);
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
