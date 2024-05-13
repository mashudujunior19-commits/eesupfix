import 'package:data/notifications/repository/survey_repository.dart';
import 'package:data/surveys/models/survey.dart';
import 'package:ui/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:ui/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/surveys/bloc/surveys_list_bloc.dart';
import 'package:ui/surveys/ui/widgets/surveys_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:auto_route/annotations.dart';

@RoutePage()
class SurveyScreen extends StatelessWidget {
  const SurveyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: context.bgImage,
          height: context.height,
          child: BlocProvider(
            create: (context) =>
                SurveysListBloc(context.read<SurveyRepository>())
                  ..add(SurveysListFetched()),
            child: BlocBuilder<SurveysListBloc, SurveysListState>(
              builder: (context, state) {
                if (state is SurveysListLoaded) {
                  return DefaultTabController(
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
                                  labelStyle:
                                      context.textTheme.displayMedium?.copyWith(
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
                                    Tab(text: 'Surveys'),
                                    Tab(text: 'Tests'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              SurveyList(
                                type: SurveyType.Survey,
                                surveys: state.surveys,
                              ),
                              SurveyList(
                                type: SurveyType.Test,
                                surveys: state.tests,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else if (state is SurveysListLoading) {
                  return const FullScreenLoadingShimmer(
                    showPopButton: true,
                    title: 'Surveys',
                  );
                } else if (state is SurveysListError) {
                  return FullScreenError(
                    exception: state.exception,
                    showPopButton: true,
                  );
                } else {
                  return FullScreenError(
                    exception: EESUpException(message: ''),
                    showPopButton: true,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
