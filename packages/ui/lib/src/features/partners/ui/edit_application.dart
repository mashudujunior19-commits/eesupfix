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
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
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
          body: BlocConsumer<ApplicationSurveysBloc, ApplicationSurveysState>(
            builder: (context, state) {
              if (state is ApplicationSurveysLoaded) {
                final surveys = state.surveys;

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Status'),
                          Text(
                            app.approvedAt != null ? 'Approved' : 'Pending',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: app.approvedAt != null
                                  ? context.colorScheme.primary
                                  : context.colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                    15.sH,
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            24.sW,
                            Icon(
                              IconlyBroken.arrowDown,
                              color:
                                  context.colorScheme.primary.withOpacity(.5),
                              size: 20,
                            ),
                          ],
                        ).animate().slideIn(index * 50),
                        itemCount: surveys.length,
                        itemBuilder: (context, index) {
                          final survey = surveys[index];
                          return _SurveyCard(
                            isCompleted: () {
                              bool isCompleted = false;
                              for (final s in app.surveyResponses) {
                                if (s.surveyId == survey.survey.id) {
                                  isCompleted = true;
                                }
                              }
                              return isCompleted;
                            }(),
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
                                          app.copyWith(
                                              surveyResponses: currentRes),
                                        ),
                                      );
                                }
                              }
                            },
                          ).animate().slideIn(index * 50);
                        },
                      ),
                    ),
                  ],
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
            listener: (BuildContext context, ApplicationSurveysState state) {
              if (state is ApplicationSurveysUpdatedSuccess) {
                // context.read<ApplicationSurveysBloc>().add(
                //       ApplicationSurveysFetched(partner),
                //     );
                context.snackBarSuccess(
                    'Form submited, You can continue with the other forms.'
                    ' if you have done all of them, your application will be '
                    'reviewd. and feedback will be communicated.');
                Navigator.of(context).pop();
              } else if (state is ApplicationSurveysUpdatedFailed) {
                // context.read<ApplicationSurveysBloc>().add(
                //       ApplicationSurveysFetched(partner),
                //     );
                context.snackBarError("Form not submited");
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
    required this.isCompleted,
    required this.indexedSurvey,
    required this.onSurveyCompleted,
  });
  final bool isCompleted;
  final IndexedSurvey indexedSurvey;
  final void Function(String? responseId) onSurveyCompleted;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 17, right: 20),
      leading: CircleAvatar(
        backgroundColor: context.colorScheme.primary.withOpacity(
          isCompleted ? 1 : .1,
        ),
        child: isCompleted
            ? const Icon(Icons.done_all, color: Colors.white)
            : Text(
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
