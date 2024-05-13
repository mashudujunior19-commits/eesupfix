import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:data/surveys/models/question.dart';
import 'package:ui/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key, required this.question});
  final Question question;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //final textTheme = theme.textTheme.displayMedium;
    final colorScheme = theme.colorScheme;
    return EESUpTextFormField(
      margin: const EdgeInsets.only(top: 15),
      hintText: 'Select Date',
      controller: TextEditingController(text: ''),
      onTap: () async {
        final result = await showCalendarDatePicker2Dialog(
          context: context,
          barrierDismissible: true,

          config: CalendarDatePicker2WithActionButtonsConfig(
            firstDate: DateTime(1900, 1, 1),
            lastDate: DateTime.now().add(const Duration(days: 10000)),
            calendarType: CalendarDatePicker2Type.single,
            selectedDayHighlightColor: colorScheme.primary,
          ),
          dialogSize: const Size(325, 400),
          //initialValue: _dialogCalendarPickerValue,
          borderRadius: BorderRadius.circular(15),
        );
        if (result != null) {
          setState(() {});
        }
      },
    );
  }
}
