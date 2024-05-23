import 'package:auto_route/auto_route.dart';
import 'package:data/partners/models/partner.dart';
import 'package:data/partners/models/partner_application.dart';
import 'package:data/partners/models/partner_survey_response.dart';
import 'package:data/partners/repository/partner_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/features/partners/bloc/application_surveys_bloc.dart';
import 'package:ui/src/features/surveys/ui/survey_card.dart';

@RoutePage()
class EditApplicationScreen extends StatelessWidget {
  const EditApplicationScreen(
      {super.key, required this.app, required this.partner});
  final Partner partner;
  final PartnerApplication app;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApplicationSurveysBloc(
        context.read<PartnerRepository>(),
      )..add(ApplicationSurveysFetched(partner)),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: Text('REF-${app.id} ${partner.title}'),
          ),
          body: BlocBuilder<ApplicationSurveysBloc, ApplicationSurveysState>(
            builder: (context, state) {
              if (state is ApplicationSurveysLoaded) {
                final surveys = state.surveys;
                return ListView.separated(
                  separatorBuilder: (context, index) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      24.sW,
                      Icon(
                        IconlyBroken.arrowDown,
                        color: context.colorScheme.primary.withOpacity(.5),
                        size: 20,
                      ),
                    ],
                  ).animate().slideIn(index * 50),
                  itemCount: surveys.length,
                  itemBuilder: (context, index) {
                    final survey = surveys[index];
                    return _SurveyCard(
                      indexedSurvey: survey,
                      onSurveyCompleted: (id) {
                        if (id != null) {
                          final response = PartnerSurveyResponse(
                            index: index,
                            surveyId: survey.survey.id,
                            responseId: id,
                          );
                          if (!app.surveyResponses.contains(response)) {
                            final currentRes = [
                              ...app.surveyResponses,
                              response
                            ];
                            context.read<ApplicationSurveysBloc>().add(
                                  ApplicationUpdated(
                                    app.copyWith(surveyResponses: currentRes),
                                  ),
                                );
                          }
                        }
                      },
                    ).animate().slideIn(index * 50);
                  },
                );
              } else if (state is ApplicationSurveysError) {
                return FullScreenError(exception: state.err);
              } else if (state is ApplicationSurveysLoading) {
                return const FullScreenLoadingShimmer();
              } else {
                return FullScreenError(
                  exception: EESUpException(
                    message: 'Something went wrong while trying to get surveys',
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class _SurveyCard extends StatelessWidget {
  const _SurveyCard({
    required this.indexedSurvey,
    required this.onSurveyCompleted,
  });
  final IndexedSurvey indexedSurvey;
  final void Function(String? responseId) onSurveyCompleted;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 17, right: 20),
      leading: CircleAvatar(
        backgroundColor: context.colorScheme.primary.withOpacity(.1),
        child: Text(
          indexedSurvey.index.toString(),
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colorScheme.primary,
          ),
        ),
      ),
      title: SurveyCard(
        survey: indexedSurvey.survey,
        margin: const EdgeInsets.all(0),
        showResults: true,
        onDone: onSurveyCompleted,
      ),
    );
  }
}
