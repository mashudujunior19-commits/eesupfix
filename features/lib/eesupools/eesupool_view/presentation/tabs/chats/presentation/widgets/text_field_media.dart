import 'package:eesup_mobile/src/features/eesupools/presentation/providers/chat_text_field_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextFieldMedia extends ConsumerWidget {
  const TextFieldMedia({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final files = ref.watch(chatTextFieldProvider).files;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          files.length,
          (index) => Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.up,
            onDismissed: (direction) {
              ref.read(chatTextFieldProvider.notifier).removeFile(index);
            },
            child: Container(
              height: 250,
              margin: const EdgeInsets.only(
                left: 13,
                right: 15,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(files[index]),
              ),
            ).animate().fadeIn(),
          ),
        ),
      ),
    );
  }
}
