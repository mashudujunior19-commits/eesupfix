import 'package:data/surveys/models/choice.dart';
import 'package:data/surveys/models/question.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ui/src/features/surveys/bloc/survey_response_bloc.dart';

class MultipleChoiceOptions extends StatelessWidget {
  const MultipleChoiceOptions({super.key, required this.question});
  final Question question;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        question.choices?.length ?? 0,
        (index) {
          return _optionCard(question.choices![index], context)
              .animate()
              .slideIn(20.00 * index);
        },
      ),
    );
  }

  Widget _optionCard(Choice choice, BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    bool isSelected = choice.isSelected;

    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? colorScheme.primary : Colors.white,
          side: BorderSide(
            color: isSelected ? colorScheme.primary : Colors.grey,
            width: 0.5,
          ),
          elevation: 0,
        ),
        onPressed: () {
          context.read<SurveyResponseBloc>().add(
                MultiChoiceResponseUpdated(
                  choice.copyWith(isSelected: !choice.isSelected),
                ),
              );
        },
        child: Padding(
          padding:
              const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
          child: Text(
            choice.choice,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
