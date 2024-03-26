import 'package:data_sources/surveys/models/survey.dart';
import 'package:features/core/extensions/bg_image_deco_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/surveys/response/ui/widgets/surveys_list_view.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class SurveySreen extends StatelessWidget {
  const SurveySreen({super.key});
  static const route = '/survey-screen';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme.displayMedium;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: context.bgImage,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Container(
                  height: 60,
                  padding: const EdgeInsets.only(left: 5, right: 16),
                  color: Colors.white,
                  child: Row(
                    children: [
                      const BackButton(),
                      15.sW,
                      SizedBox(
                        height: 26,
                        child: TabBar(
                          dividerColor: Colors.transparent,
                          indicatorPadding: const EdgeInsets.all(0),
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          labelColor: Colors.white,
                          labelStyle: textTheme!.copyWith(
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
                            color: theme.colorScheme.primary,
                          ),
                          tabs: const [
                            Tab(text: 'Surveys'),
                            Tab(text: 'Tests'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      SurveyListView(type: SurveyType.Survey),
                      SurveyListView(type: SurveyType.Test),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
