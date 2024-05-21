import 'package:data/eesupools/models/eesupool.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';

typedef UpdateTopics = ({
  List<String> current,
  List<String> suggestions,
});

class ReviewTopicSuggestionsDialog extends StatefulWidget {
  const ReviewTopicSuggestionsDialog({super.key, required this.pool});
  final EESUpool pool;

  @override
  State<ReviewTopicSuggestionsDialog> createState() =>
      _ReviewTopicSuggestionsDialogState();
}

class _ReviewTopicSuggestionsDialogState
    extends State<ReviewTopicSuggestionsDialog> {
  List<String> currentTopics = [];
  List<String> suggestionsTopics = [];
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentTopics.addAll(widget.pool.chatTags ?? []);
    currentTopics.sort((a, b) => a.compareTo(b));
    suggestionsTopics.addAll(widget.pool.chatTagsSuggestions ?? []);
    suggestionsTopics.sort((a, b) => a.compareTo(b));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop(
              (current: currentTopics, suggestions: suggestionsTopics),
            );
          },
        ),
        title: const Text('💭 Suggestions'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _TabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    children: [
                      if (currentTopics.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 150),
                          child: FullScreenError(
                            isError: false,
                            exception: EESUpException(
                              message: 'Nothing to show here.',
                            ),
                          ),
                        )
                      else
                        for (final topic in currentTopics)
                          ListTile(
                            contentPadding: const EdgeInsets.only(top: 15),
                            title: Text(
                              topic,
                              style: context.textTheme.labelMedium?.copyWith(
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            trailing: IconButton(
                              icon: const Icon(IconlyLight.delete),
                              onPressed: () {
                                setState(() {
                                  currentTopics.remove(topic);
                                });
                              },
                            ),
                          ),
                    ],
                  ),
                  if (suggestionsTopics.isEmpty)
                    FullScreenError(
                      isError: false,
                      exception: EESUpException(
                        message: 'Nothing to show here.',
                      ),
                    )
                  else
                    ListView(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      children: [
                        for (final topic in suggestionsTopics)
                          ListTile(
                            contentPadding: const EdgeInsets.only(top: 15),
                            title: Text(
                              topic,
                              style: context.textTheme.labelMedium?.copyWith(
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            subtitle: Row(
                              children: [
                                TextButton(
                                  child: const Text('Approve'),
                                  onPressed: () {
                                    setState(() {
                                      currentTopics.add(topic);
                                      suggestionsTopics.remove(topic);
                                    });
                                    context.snackBarSuccess('Approved $topic');
                                  },
                                ),
                                20.sW,
                                TextButton(
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      suggestionsTopics.remove(topic);
                                    });
                                    context.snackBarSuccess('Removed $topic');
                                  },
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 55,
      color: Colors.white,
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 20),
      child: TabBar(
        dividerColor: Colors.transparent,
        //indicatorPadding: const EdgeInsets.all(0),
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelColor: Colors.white,
        labelStyle: context.textTheme.displayMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        unselectedLabelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: RectangularIndicator(
          bottomLeftRadius: 8,
          bottomRightRadius: 8,
          topLeftRadius: 8,
          topRightRadius: 8,
          color: context.colorScheme.primary,
        ),
        tabs: const [
          Text('Current topics'),
          Text('Suggestions'),
        ],
      ),
    );
  }
}
