// ignore_for_file: use_build_context_synchronously
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/core/utils/date_formatter.dart';
import 'package:features/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class IndividualForm extends StatelessWidget {
  IndividualForm({super.key, required this.tabController});
  final TabController tabController;
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return ListView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 400),
      children: [
        EESUpTextFormField(
          label: 'First Name',
          controller: _nameController,
        ).animate().slideIn(0),
        EESUpTextFormField(
          label: 'Last Name',
          controller: _lastNameController,
        ).animate().slideIn(50),
        _idForm(textTheme).animate().slideIn(150),
        EESUpTextFormField(
          visible: 1 == 1,
          label: 'Identity Number',
          controller: _idController,
        ).animate().slideIn(200),
        if (1 == 1)
          EESUpTextFormField(
            label: 'Date of Birth',
            readOnly: true,
            controller: TextEditingController(
              text: DateFormatter.formatDate(
                DateTime.now(),
              ),
            ),
            onTap: () async {
              final DateTime? dob = await showOmniDateTimePicker(
                context: context,
                type: OmniDateTimePickerType.date,
                firstDate: DateTime(1910, 01, 01),
                initialDate: DateTime.now().subtract(
                  const Duration(days: 18 * 365),
                ),
                lastDate: DateTime.now().subtract(
                  const Duration(days: 18 * 365),
                ),
              );
              if (dob == null) return;

              // updateDob(ref, dob);
            },
          ).animate().slideIn(100),
        30.sH,
        ElevatedButton(
          onPressed: () async {
            // updateUserInfo(ref);
            // if (!validateNames(ref, context)) return;
            // if (!validateCitizenshipAndID(ref, context)) return;
            // if (!validateDOB(ref, context)) return;
            // await validateAndNavigate(ref, context);
          },
          child: const Text('Next'),
        )
      ],
    );
  }

  DateTime extractDateOfBirth(String idNumber) {
    // Extract the date of birth from the ID number
    String year = idNumber.substring(0, 2);
    String month = idNumber.substring(2, 4);
    String day = idNumber.substring(4, 6);
    // Construct the date of birth string in the format yyyy-mm-dd
    String d = '$year-$month-$day';
    final date = DateFormat('yy-MM-dd').parse(d);

    return date;
  }

  Column _idForm(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Are you a South African Citizen?',
          style: textTheme.labelMedium?.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 5),
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade50.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.blueGrey.shade100,
              width: 0.9,
            ),
          ),
          child: DropdownButton<bool>(
            // Initial Value
            value: false,
            isExpanded: true,
            isDense: false,
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(10),
            // Down Arrow Icon
            icon: const Icon(IconlyLight.arrowDown2, size: 20),
            underline: const SizedBox(),
            // Array list of items
            items: [true, false].map((bool items) {
              return DropdownMenuItem(
                value: items,
                child: Text(
                  items ? 'Yes, I am.' : 'No, I am not.',
                  style: textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (bool? newValue) {
              if (newValue == null) return;
              // updateIsRSACitizen(ref, newValue);
            },
          ),
        ),
      ],
    );
  }
}
