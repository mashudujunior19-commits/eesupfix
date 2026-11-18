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

class IndividualForm extends StatefulWidget {
  const IndividualForm({
    super.key,
    required this.form,
    required this.tabController,
  });
  final RegisterForm form;
  final TabController tabController;

  @override
  State<IndividualForm> createState() => _IndividualFormState();
}

class _IndividualFormState extends State<IndividualForm> {
  bool _isSubmitting = false;

  RegisterForm get form => widget.form;
  TabController get tabController => widget.tabController;

  /// Applies a change on top of the cubit's current state. [form] is only the
  /// copy from the last build, so building on it drops any field that changed
  /// since then (autofill, or several inputs landing before the next frame).
  void _update(RegisterForm Function(RegisterForm current) change) {
    final cubit = context.read<RegisterCubit>();
    cubit.updateForm(change(cubit.state));
  }

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
            _update((current) => current.copyWith(firstName: v));
          },
        ).animate().slideIn(0),
        EESUpTextFormField(
          initialValue: form.lastName,
          label: 'Last Name',
          onChanged: (value) {
            final v = value.isEmpty ? null : value;
            _update((current) => current.copyWith(lastName: v));
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
                  _update(
                    (current) => current.copyWith(isRSACitizen: v ?? false),
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
              _update(
                (current) => current.copyWith(dob: null, idNumber: v),
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
              if (!mounted) return;
              _update(
                (current) => current.copyWith(dob: dob, idNumber: null),
              );
            },
          ).animate().slideIn(150),
        30.sH,
        ElevatedButton(
          onPressed: _isSubmitting ? null : _handleNext,
          child: _isSubmitting
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Next'),
        )
      ],
    );
  }

  Future<void> _handleNext() async {
    if (_isSubmitting) return;

    FocusScope.of(context).unfocus();

    // Validate what the cubit holds now, not the copy from the last build.
    final form = context.read<RegisterCubit>().state;

    if (form.firstName == null || form.firstName!.trim().isEmpty) {
      context.snackBarError('Please provide your first name');
      return;
    }

    if (form.lastName == null || form.lastName!.trim().isEmpty) {
      context.snackBarError('Please provide your last name');
      return;
    }

    if (form.idNumber == null && form.dob == null) {
      if (form.isRSACitizen) {
        context.snackBarError("Please provide your South African ID number.");
        return;
      } else {
        context.snackBarError("Please provide your date of birth.");
        return;
      }
    }

    if (form.idNumber != null) {
      if (!form.isValidIdNumber()) {
        context.snackBarError("Invalid ID number.");
        return;
      }
    }

    if (!form.isOfAge()) {
      context.snackBarError(
        "You must be 18 years and above to Register on Towris.",
      );
      return;
    }

    if (form.isRSACitizen) {
      setState(() => _isSubmitting = true);
      context.loaderOverlay.show();

      final results = await context
          .read<AuthRepository>()
          .idNumberExists(form.idNumber!);

      if (!mounted) return;
      context.loaderOverlay.hide();
      setState(() => _isSubmitting = false);

      // Use fold result to determine if we should proceed
      final hasError = results.fold(
        (left) {
          context.snackBarError(left.message);
          return true;
        },
        (isUsed) {
          if (isUsed) {
            context.snackBarError(
              'An account with this ID number already exists',
            );
            return true;
          }
          return false;
        },
      );

      if (!hasError) {
        tabController.animateTo(tabController.index + 1);
      }
    } else {
      tabController.animateTo(tabController.index + 1);
    }
  }
}
