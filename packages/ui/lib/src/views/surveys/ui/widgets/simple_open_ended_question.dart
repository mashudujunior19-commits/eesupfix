import 'package:data/surveys/models/question.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';
import 'package:ui/src/views/surveys/bloc/survey_response_bloc.dart';

class SimpleOpenEndedQuestion extends StatelessWidget {
  const SimpleOpenEndedQuestion({super.key, required this.question});
  final Question question;

  @override
  Widget build(BuildContext context) {
    return EESUpTextFormField(
      maxLines: 5,
      autoFocus: false,
      hintText: 'Type your answer here...',
      initialValue: question.openEndedAnswer,
      onChanged: (value) {
        if (value.isNotEmpty) {
          context.read<SurveyResponseBloc>().add(
                QuestionResponseUpdated(
                  question.copyWith(openEndedAnswer: value),
                ),
              );
        } else {
          context.read<SurveyResponseBloc>().add(
                QuestionResponseUpdated(
                  question.copyWith(openEndedAnswer: null),
                ),
              );
        }
      },
    );
  }
}
