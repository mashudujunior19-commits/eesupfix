import 'package:data_sources/surveys/models/question.dart';
import 'package:features/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({super.key, required this.question});
  final Question question;

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return EESUpTextFormField(
      margin: const EdgeInsets.only(top: 15),
      hintText: 'Select date and time',
      controller: TextEditingController(text: ''),
      onTap: () async {
        final result = await showOmniDateTimePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
          lastDate: DateTime.now().add(
            const Duration(days: 10000),
          ),
          is24HourMode: false,
          isShowSeconds: false,
          minutesInterval: 1,
          secondsInterval: 1,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          constraints: const BoxConstraints(
            maxWidth: 350,
            maxHeight: 650,
          ),
          transitionBuilder: (context, anim1, anim2, child) {
            return FadeTransition(
              opacity: anim1.drive(
                Tween(
                  begin: 0,
                  end: 1,
                ),
              ),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
          barrierDismissible: true,
          selectableDayPredicate: (dateTime) {
            // Disable 25th Feb 2023
            if (dateTime == DateTime(2023, 2, 25)) {
              return false;
            } else {
              return true;
            }
          },
        );
        if (result != null) {
          setState(() {});
        }
      },
    );
  }
}
