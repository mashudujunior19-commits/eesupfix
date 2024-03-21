import 'package:data_sources/eesupools/models/chat_message.dart';
import 'package:features/eesupools/eesupool_view/presentation/tabs/chats/presentation/widgets/chat_bubble_media_files.dart';
import 'package:features/eesupools/eesupool_view/presentation/tabs/chats/presentation/widgets/chat_rich_text.dart';
import 'package:flutter/material.dart';

class ChatReplyBubble extends StatelessWidget {
  const ChatReplyBubble({super.key, this.reply, required this.tags});
  final ChatMessage? reply;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    if (reply == null) return const SizedBox.shrink();

    // final memberId = ref.watch(eesupoolViewProvider)?.memberId;
    // final isMe = (memberId == reply?.authorId);

    final isMe = 1 == 1;

    final theme = Theme.of(context);
    final textTheme = theme.textTheme.bodySmall;
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
                  style: textTheme!.copyWith(
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
          ChatMediaFiles(mediaFiles: reply?.media),
          ChatBubbleRichText(message: reply?.content, tags: tags)
        ],
      ),
    );
  }
}
