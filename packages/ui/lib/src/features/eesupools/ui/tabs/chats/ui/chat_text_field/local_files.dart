import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ChatTextFieldLocalFiles extends StatelessWidget {
  const ChatTextFieldLocalFiles({super.key, required this.files});
  final List<File> files;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          files.length,
          (index) => Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.up,
            onDismissed: (direction) {},
            child: Container(
              height: 250,
              margin: const EdgeInsets.only(
                left: 15,
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
