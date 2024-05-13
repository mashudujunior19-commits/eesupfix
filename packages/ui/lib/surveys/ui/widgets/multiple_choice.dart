import 'package:data/surveys/models/option.dart';
import 'package:data/surveys/models/question.dart';
import 'package:ui/core/extensions/slide_in_animation_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MultipleChoiceOptions extends StatelessWidget {
  const MultipleChoiceOptions({super.key, required this.question});
  final Question question;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        question.options?.length ?? 0,
        (index) {
          return _optionCard(question.options![index], context)
              .animate()
              .slideIn(20.00 * index);
        },
      ),
    );
  }

  Widget _optionCard(Option option, BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    bool isSelected = option.isSelected;

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
          // updateQuestionOption(
          //   ref,
          //   question,
          //   option.copyWith(isSelected: !isSelected),
          // );
        },
        child: Padding(
          padding:
              const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
          child: Text(
            option.option,
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
