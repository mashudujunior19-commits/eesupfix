import 'package:eesup_mobile/src/features/eesupools/presentation/providers/chat_text_field_notifier.dart';
import 'package:eesup_mobile/src/features/eesupools/presentation/chats/chat_rich_text.dart';
import 'package:eesup_mobile/src/features/eesupools/presentation/chats/text_field_reply_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextFieldReplyChat extends ConsumerWidget {
  const TextFieldReplyChat({super.key, required this.tags});
  final List<String> tags;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme.displayMedium;
    final replyMessage = ref.watch(chatTextFieldProvider).reply;
    if (replyMessage == null) return const SizedBox.shrink();
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Reply to: ${replyMessage.authorName}',
                  style: textTheme!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ref
                      .read(chatTextFieldProvider.notifier)
                      .setReplyMessage(null);
                },
                child: const Icon(Icons.close, size: 17),
              ),
            ],
          ),
          const SizedBox(height: 5),
          TextFieldReplyMedia(media: replyMessage.media),
          if (replyMessage.content != null)
            ChatBubbleRichText(message: replyMessage.content, tags: tags),
        ],
      ),
    );
  }
}
