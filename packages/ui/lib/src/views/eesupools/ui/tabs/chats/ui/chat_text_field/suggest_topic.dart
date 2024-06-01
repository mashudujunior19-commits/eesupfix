import 'package:data/eesupools/models/eesupool.dart';
import 'package:flutter/material.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';

class SuggestTopicDialog extends StatefulWidget {
  const SuggestTopicDialog({super.key, required this.pool});
  final EESUpool pool;

  @override
  State<SuggestTopicDialog> createState() => _SuggestTopicDialogState();
}

class _SuggestTopicDialogState extends State<SuggestTopicDialog> {
  List<String> currentTopics = [];

  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentTopics.addAll(widget.pool.chatTagsSuggestions ?? []);
    currentTopics.sort((a, b) => a.compareTo(b));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {   
            Navigator.of(context).pop(currentTopics);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        children: [
          Text(
            '💭 Suggest a new Topic.',
            style: context.textTheme.labelSmall,
            textAlign: TextAlign.start,
          ),
          // 20.sH,
          EESUpTextFormField(
            hintText: '#EESUpleasure',
            controller: controller,
          ),
          5.sH,
          if (currentTopics.isNotEmpty)
            Text('Current Topics',
                textAlign: TextAlign.start,
                style: context.textTheme.labelSmall),
          5.sH,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final topic in currentTopics)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      topic,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
              ],
            ),
          ),
          20.sH,
          ElevatedButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              String topic = controller.text;

              if (topic.isEmpty) return;

              if (!topic.startsWith("#")) {
                context.snackBarError("invalid topic, please start with #");
                return;
              }

              final suggestions = widget.pool.chatTagsSuggestions ?? [];

              if (topic.isNotEmpty) {
                if (suggestions.contains(topic)) {
                  context.snackBarError('Topic already exists!!!');
                  return;
                }
              }
              setState(() {
                currentTopics.add(topic);
              });

              controller.clear();

              context.snackBarSuccess("Captured");
            },
            child: Text(
              'Suggest',
              style: context.textTheme.labelMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
