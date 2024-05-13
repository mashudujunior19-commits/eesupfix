import 'dart:io';
import 'package:data/surveys/models/question.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class FilePickerQuestion extends StatelessWidget {
  const FilePickerQuestion({super.key, required this.question});
  final Question question;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Column(
      children: [
        15.sH,
        TextButton(
          onPressed: () async {
            // final newFiles = await _pickFiles();
            // List<File> oldFiles = [...question.pickedfiles ?? [], ...newFiles];

            // updateQuestionResponse(
            //   ref,
            //   question.copyWith(pickedfiles: oldFiles),
            // );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(IconlyLight.upload, size: 17),
              10.sW,
              Text(
                'Select from device',
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.primary,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        15.sH,
        if (question.pickedfiles != null)
          ...List.generate(
            question.pickedfiles!.length,
            (index) {
              final file = question.pickedfiles![index];
              return Container(
                margin: const EdgeInsets.only(left: 15, right: 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        file.path.split('/').last,
                        style: textTheme.labelSmall?.copyWith(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // List<File> oldFiles = [...question.pickedfiles ?? []];
                        // oldFiles.removeAt(index);
                        // updateQuestionResponse(
                        //   ref,
                        //   question.copyWith(
                        //     pickedfiles: oldFiles,
                        //   ),
                        // );
                      },
                      icon: const Icon(IconlyLight.delete, size: 18),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  // ignore: unused_element
  Future<List<File>> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['png', 'jpg', 'pdf', 'doc'],
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      return files;
    } else {
      return [];
    }
  }
}
