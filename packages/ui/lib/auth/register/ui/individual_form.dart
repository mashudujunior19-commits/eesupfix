// ignore_for_file: use_build_context_synchronously
import 'package:ui/auth/register/bloc/registration_bloc.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:ui/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/core/utils/date_formatter.dart';
import 'package:ui/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class IndividualForm extends StatelessWidget {
  const IndividualForm({
    super.key,
    required this.form,
    required this.tabController,
  });
  final SignUpForm form;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 400),
      children: [
        EESUpTextFormField(
          initialValue: form.firstName,
          label: 'First Name',
          onChanged: (value) {
            final v = value.isEmpty ? null : value;
            context.read<RegistrationBloc>().add(
                  SignUpFormUpdated(form.copyWith(firstName: v)),
                );
          },
        ).animate().slideIn(0),
        EESUpTextFormField(
          initialValue: form.lastName,
          label: 'Last Name',
          onChanged: (value) {
            final v = value.isEmpty ? null : value;
            context.read<RegistrationBloc>().add(
                  SignUpFormUpdated(form.copyWith(lastName: v)),
                );
          },
        ).animate().slideIn(50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(child: Text('I am a South African citizen?')),
            Checkbox(
              value: form.isRSACitizen,
              onChanged: (v) {
                context.read<RegistrationBloc>().add(
                      SignUpFormUpdated(
                        form.copyWith(
                          isRSACitizen: v,
                          dob: null,
                          idNumber: null,
                        ),
                      ),
                    );
              },
            )
          ],
        ).animate().slideIn(100),
        if (form.isRSACitizen)
          EESUpTextFormField(
            visible: form.isRSACitizen,
            label: 'Identity Number',
            type: TextInputType.number,
            initialValue: form.idNumber,
            onChanged: (value) {
              final v = value.isEmpty ? null : value;
              context.read<RegistrationBloc>().add(
                    SignUpFormUpdated(form.copyWith(idNumber: v, dob: null)),
                  );
            },
          ).animate().slideIn(150)
        else
          EESUpTextFormField(
            label: 'Date of Birth',
            readOnly: true,
            controller: TextEditingController(
              text: form.dob == null
                  ? null
                  : DateFormatter.formatDate(
                      form.dob!,
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
              context.read<RegistrationBloc>().add(
                    SignUpFormUpdated(form.copyWith(dob: dob, idNumber: null)),
                  );
            },
          ).animate().slideIn(150),
        30.sH,
        ElevatedButton(
          onPressed: () async {
            tabController.animateTo(tabController.index + 1);
          },
          child: const Text('Next'),
        )
      ],
    );
  }
}
