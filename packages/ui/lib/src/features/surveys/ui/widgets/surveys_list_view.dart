import 'package:data/surveys/models/survey.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/features/surveys/ui/survey_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:data/utils/eesup_exception.dart';

class SurveyList extends StatelessWidget {
  const SurveyList({super.key, required this.type, required this.surveys});
  final SurveyType type;
  final List<Survey> surveys;
  @override
  Widget build(BuildContext context) {
    if (surveys.isEmpty) {
      return FullScreenError(
        isError: false,
        exception: EESUpException(
          message: 'There are no ${type.toString()}s available.',
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.only(left: 5, right: 5),
      itemCount: surveys.length,
      itemBuilder: (context, index) {
        final survey = surveys[index];
        return SurveyCard(survey: survey).animate().slideIn(index * 50);
      },
    );
  }
}
