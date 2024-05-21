import 'package:flutter/material.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';

class TopicSuggestions extends StatelessWidget {
  const TopicSuggestions({
    super.key,
    required this.visible,
    required this.chatTags,
    required this.controller,
  });

  final bool visible;
  final TextEditingController controller;
  final List<String> chatTags;

  @override
  Widget build(BuildContext context) {
    if (chatTags.isEmpty) return 0.sH;
    if (!visible) return 0.sH;
    final textTheme = Theme.of(context).textTheme.bodyMedium;
    return Container(
      width: MediaQuery.sizeOf(context).width,
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: List.generate(
          chatTags.length,
          (index) => GestureDetector(
            onTap: () {
              //replace the last word with the tag
              final words = controller.text.split("#");
              words.removeLast();
              words.add(chatTags[index]);
              controller.text =
                  controller.text.isNotEmpty ? words.join(" ") : words.join();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 13, right: 10),
              child: Text(
                chatTags[index],
                style: textTheme!.copyWith(
                  color: Colors.grey.shade700,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
