import 'package:data/surveys/models/question.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SliderQuestion extends StatelessWidget {
  const SliderQuestion({super.key, required this.question});
  final Question question;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return SfSlider(
      min: question.sliderMin == null
          ? 1
          : double.parse(question.sliderMin!.toString()),
      max: question.sliderMin == null
          ? 10
          : double.parse(question.sliderMax!.toString()),
      value: question.sliderValue ?? 0,
      interval: double.tryParse(question.sliderInterval.toString()) ?? 1.00,
      showTicks: false,
      showLabels: true,
      enableTooltip: true,
      activeColor: colorScheme.primary,
      minorTicksPerInterval: 0,
      onChanged: (dynamic value) {
        // double v = value;
        // int v2 = v.round();
        // updateQuestionResponse(
        //   ref,
        //   question.copyWith(sliderValue: v2),
        // );
      },
    );
  }
}
