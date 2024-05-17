import 'package:data/surveys/models/question.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({super.key, required this.question});
  final Question question;

  @override
  Widget build(BuildContext context) {
    return EESUpTextFormField(
      margin: const EdgeInsets.only(top: 15),
      hintText: 'Select time',
      controller: TextEditingController(text: ''),
      onTap: () async {
        // final result = await showTimePicker(
        //   context: context,
        //   initialTime: TimeOfDay.now(),
        // );
        // if (result != null) {
        //   // setState(() {
        //   //   widget.question.timePicked = result.format(context);
        //   // });
        // }
      },
    );
  }
}
