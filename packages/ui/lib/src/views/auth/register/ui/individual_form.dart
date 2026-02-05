// ignore_for_file: use_build_context_synchronously
import 'package:data/auth/repository/auth_repository.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/utils/date_formatter.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:ui/src/views/auth/register/cubit/register_cubit.dart';
import 'package:ui/src/views/auth/register/cubit/register_form.dart';

class IndividualForm extends StatelessWidget {
  const IndividualForm({
    super.key,
    required this.form,
    required this.tabController,
  });
  final RegisterForm form;
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
            context.read<RegisterCubit>().updateForm(
                  form.copyWith(
                    firstName: v,
                    lastName: form.lastName,
                    dob: form.dob,
                    isRSACitizen: form.isRSACitizen,
                    idNumber: form.idNumber,
                  ),
                );
          },
        ).animate().slideIn(0),
        EESUpTextFormField(
          initialValue: form.lastName,
          label: 'Last Name',
          onChanged: (value) {
            final v = value.isEmpty ? null : value;
            context.read<RegisterCubit>().updateForm(
                  form.copyWith(
                    firstName: form.firstName,
                    lastName: v,
                    dob: form.dob,
                    isRSACitizen: form.isRSACitizen,
                    idNumber: form.idNumber,
                  ),
                );
          },
        ).animate().slideIn(50),
        Container(
          margin: const EdgeInsets.only(top: 15, bottom: 10),
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            border: Border.all(width: .3, color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'I am a South African citizen?',
                  style: context.textTheme.bodyMedium?.copyWith(),
                ),
              ),
              Checkbox(
                value: form.isRSACitizen,
                onChanged: (v) {
                  context.read<RegisterCubit>().updateForm(
                        form.copyWith(
                          firstName: form.firstName,
                          lastName: form.lastName,
                          dob: form.dob,
                          isRSACitizen: v ?? false,
                          idNumber: form.idNumber,
                        ),
                      );
                },
              )
            ],
          ).animate().slideIn(100),
        ),
        if (form.isRSACitizen)
          EESUpTextFormField(
            visible: form.isRSACitizen,
            label: 'Identity Number',
            type: TextInputType.number,
            initialValue: form.idNumber,
            onChanged: (value) {
              final v = value.isEmpty ? null : value;
              context.read<RegisterCubit>().updateForm(
                    form.copyWith(
                      firstName: form.firstName,
                      lastName: form.lastName,
                      dob: null,
                      isRSACitizen: form.isRSACitizen,
                      idNumber: v,
                    ),
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
              context.read<RegisterCubit>().updateForm(
                    form.copyWith(
                      firstName: form.firstName,
                      lastName: form.lastName,
                      dob: dob,
                      isRSACitizen: form.isRSACitizen,
                      idNumber: null,
                    ),
                  );
            },
          ).animate().slideIn(150),
        30.sH,
        ElevatedButton(
          onPressed: () async {
            FocusScope.of(context).unfocus();
            if (form.firstName == null) {
              context.snackBarError('Please provide your first name');
              return;
            }

            if (form.lastName == null) {
              context.snackBarError('Please provide your last name');
              return;
            }

            if (form.idNumber == null && form.dob == null) {
              if (form.isRSACitizen) {
                context.snackBarError(
                    "Please provide your South African ID number.");
                return;
              } else {
                context.snackBarError("Please provide your date of birth.");
                return;
              }
            }

            if (form.idNumber != null) {
              if (!form.isValidIdNumber()) {
                context.snackBarError("Invalid Id number.");
                return;
              }
            }

            if (!form.isOfAge()) {
              context.snackBarError(
                "You must be 18 years and above to Register on EESUp.",
              );
              return;
            }

            if (form.isRSACitizen) {
              context.loaderOverlay.show();
              final results = await context
                  .read<AuthRepository>()
                  .idNumberExists(form.idNumber!);
              context.loaderOverlay.hide();

              results.fold((left) {
                context.snackBarError(left.message);
                return;
              }, (isUsed) {
                if (isUsed) {
                  context.snackBarError(
                    'An account with this id number already exists',
                  );
                  return;
                } else {
                  tabController.animateTo(tabController.index + 1);
                }
              });
            } else {
              tabController.animateTo(tabController.index + 1);
            }
          },
          child: const Text('Next'),
        )
      ],
    );
  }
}
