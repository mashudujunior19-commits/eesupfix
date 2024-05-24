import 'package:auto_route/auto_route.dart';
import 'package:data/notifications/repository/survey_repository.dart';
import 'package:data/surveys/models/question.dart';
import 'package:data/surveys/models/survey.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/features/surveys/bloc/survey_response_bloc.dart';
import 'package:ui/src/features/surveys/ui/widgets/current_question_view.dart';

///Displays the current question in a survey.
///as well as the navigation and submit buttons.
@RoutePage()
class ResponseScreen extends StatelessWidget {
  const ResponseScreen({super.key, required this.survey});
  final Survey survey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SurveyResponseBloc()
        ..add(
          ResponseInitialized(survey),
        ),
      child: SafeArea(
        child: BlocBuilder<SurveyResponseBloc, SurveyResponseState>(
          builder: (context, state) {
            if (state is CurrentResponseSurvey) {
              final question = state.currentQuestion;
              return Scaffold(
                appBar: _appBar(context, question, state),
                body: CurrentQuestionView(question: question),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton:
                    _navigationButtons(state, context, question),
              );
            } else {
              return Scaffold(
                appBar: AppBar(),
                body: const FullScreenLoadingShimmer(),
              );
            }
          },
        ),
      ),
    );
  }

  Padding _navigationButtons(
    CurrentResponseSurvey state,
    BuildContext context,
    Question question,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        bottom: 20,
        right: 15,
      ),
      child: Row(
        children: [
          if (state.index != 0)
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 115,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  elevation: 0,
                ),
                onPressed: () {
                  context.read<SurveyResponseBloc>().add(
                        NextQuestionPressed(state.index - 1),
                      );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(IconlyLight.arrowLeft),
                    Text('  Back'),
                  ],
                ),
              ),
            ),
          () {
            int next = state.index + 1;
            return Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  if (canProcced(question)) {
                    if (next < state.survey.questions.length) {
                      context.read<SurveyResponseBloc>().add(
                            NextQuestionPressed(next),
                          );
                    } else {
                      context.loaderOverlay.show();
                      final repo = context.read<SurveyRepository>();
                      final results = await repo.submitSurveyResponse(
                        state.survey,
                      );
                      context.loaderOverlay.hide();
                      results.fold((l) {
                        context.snackBarError(l.message);
                      }, (id) {
                        if (id != null) {
                          context.snackBarSuccess('Response captured');
                          Navigator.of(context).pop(id);
                        } else {
                          context.snackBarError(
                            'Something went wrong while trying to save the response.',
                          );
                        }
                      });
                    }
                  } else {
                    context.snackBarError(
                      'This question is required.',
                    );
                  }
                },
                child: next == state.survey.questions.length
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.done_all),
                          Text('  Submit'),
                        ],
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(IconlyLight.arrowRight),
                          Text('  Next'),
                        ],
                      ),
              ),
            );
          }(),
        ],
      ),
    );
  }

  bool canProcced(Question question) {
    if (!question.isRequired) {
      return true;
    }

    if (question.type == QuestionType.multipleChoice) {
      return question.choices!.any((element) => element.isSelected);
    } else if (question.type == QuestionType.openEnded) {
      return question.openEndedAnswer != null &&
          question.openEndedAnswer!.isNotEmpty;
    } else if (question.type == QuestionType.slider) {
      return question.sliderValue != null;
    } else if (question.type == QuestionType.rating) {
      return question.ratingValue != null;
    } else if (question.type == QuestionType.fileUpload) {
      return question.pickedfiles != null && question.pickedfiles!.isNotEmpty;
    } else if (question.type == QuestionType.date) {
      return question.pickedDate != null;
    } else if (question.type == QuestionType.time) {
      return question.timePicked != null;
    } else if (question.type == QuestionType.dateTime) {
      return question.dateTimePicked != null;
    } else {
      return false;
    }
  }

  AppBar _appBar(
      BuildContext context, Question question, CurrentResponseSurvey state) {
    return AppBar(
      leading: BackButton(
        onPressed: () {
          context.showAlertDialog(
            'Do you want to exit?',
            'Are you sure you want to exit? Your progress will be Lost.',
            positiveColor: context.colorScheme.error,
            negativeColor: context.colorScheme.primary,
            negativeText: 'No, Continue',
            positiveText: 'Yes, Exit',
            onNegative: () {},
            onPositive: () {
              Navigator.pop(context);
            },
          );
        },
      ),
      title: Text(
        'Question ${question.questionId}/${state.survey.questions.length}',
      ),
    );
  }
}
