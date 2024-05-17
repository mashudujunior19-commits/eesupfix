import 'package:data/surveys/models/question.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';

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
        // updateQuestionResponse(
        //   ref,
        //   question.copyWith(openEndedAnswer: value),
        // );
      },
    );
  }
}
