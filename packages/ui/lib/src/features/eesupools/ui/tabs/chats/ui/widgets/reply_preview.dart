import 'package:data/eesupools/models/chat_message.dart';
import 'package:data/eesupools/models/eesupool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlighted_text/flutter_highlighted_text.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/features/eesupools/ui/tabs/chats/ui/widgets/message_attachments.dart';

class ReplyPreview extends StatelessWidget {
  const ReplyPreview({
    super.key,
    this.reply,
    required this.pool,
    required this.tags,
  });
  final ChatMessage? reply;
  final List<String> tags;
  final EESUpool pool;

  @override
  Widget build(BuildContext context) {
    if (reply == null) return const SizedBox.shrink();

    final memberId = pool.memberId;
    final isMe = (memberId == reply?.authorId);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(21),
          topRight: Radius.circular(21),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Text(
                  isMe ? 'Me' : reply?.authorName ?? '~',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: isMe ? Colors.grey.withOpacity(.4) : Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 5),
                Icon(
                  Icons.reply_outlined,
                  color: isMe ? Colors.grey.withOpacity(.4) : Colors.black,
                  size: 15,
                ),
              ],
            ),
          ),
          MessageAttachments(mediaFiles: reply?.media),
          if (reply != null)
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 5,
              ),
              child: HighlightedText(
                reply!.content!,
                patterns: [...pool.chatTags ?? []],
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
            )
        ],
      ),
    );
  }
}
