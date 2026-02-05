import 'package:email_validator/email_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/views/auth/register/cubit/register_cubit.dart';

import 'package:ui/src/views/auth/register/cubit/register_form.dart';
import 'package:ui/src/views/auth/register/ui/password_strength.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'email_and_phone_tab_container.dart';

class CredentialsForm extends StatefulWidget {
  const CredentialsForm({
    super.key,
    required this.form,
    required this.tabController,
  });
  final RegisterForm form;
  final TabController tabController;

  @override
  State<CredentialsForm> createState() => _CredentialsFormState();
}

class _CredentialsFormState extends State<CredentialsForm> {
  bool _isValidPassword = false;
  bool _isSubmitting = false;

  RegisterForm get form => widget.form;
  TabController get tabController => widget.tabController;

  Future<void> _handleNext() async {
    if (_isSubmitting) return;

    FocusScope.of(context).unfocus();

    final tempEmail = form.email?.trim() ?? '';
    final tempPhone = form.phone?.trim() ?? '';

    if (tempPhone.isEmpty && tempEmail.isEmpty) {
      context.snackBarError('Please provide your email or phone');
      return;
    }

    setState(() => _isSubmitting = true);

    if (tempEmail.isNotEmpty) {
      if (!EmailValidator.validate(tempEmail)) {
        setState(() => _isSubmitting = false);
        context.snackBarError('Invalid email address');
        return;
      }

      context.loaderOverlay.show();
      final results = await context.read<RegisterCubit>().emailExistsResult(
            tempEmail,
          );
      if (!mounted) return;
      context.loaderOverlay.hide();

      final shouldReturn = results.fold(
        (error) {
          context.snackBarError(error.message);
          return true;
        },
        (exists) {
          if (exists) {
            context.snackBarError(
              'This email address is already registered to another account',
            );
            return true;
          }
          return false;
        },
      );

      if (shouldReturn) {
        setState(() => _isSubmitting = false);
        return;
      }
    }

    if (tempPhone.isNotEmpty) {
      context.loaderOverlay.show();
      final results = await context.read<RegisterCubit>().phoneExistsResult(
            tempPhone,
          );
      if (!mounted) return;
      context.loaderOverlay.hide();

      final shouldReturn = results.fold(
        (error) {
          context.snackBarError(error.message);
          return true;
        },
        (exists) {
          if (exists) {
            context.snackBarError(
              'This phone is already registered to another account',
            );
            return true;
          }
          return false;
        },
      );

      if (shouldReturn) {
        setState(() => _isSubmitting = false);
        return;
      }
    }

    if (!_isValidPassword) {
      setState(() => _isSubmitting = false);
      context.snackBarError(
        'Your password must meet all the requirements.',
      );
      return;
    }

    setState(() => _isSubmitting = false);
    final next = tabController.index + 1;
    tabController.animateTo(next);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 400),
      children: [
        EmailAndPhoneTabContainer(
          onEmailChanged: (email) {
            context.read<RegisterCubit>().updateForm(
                  form.copyWith(
                    email: email,
                    phone: null,
                    password: form.password,
                    retypedPassword: form.retypedPassword,
                  ),
                );
          },
          onPhoneChanged: (phone) {
            context.read<RegisterCubit>().updateForm(
                  form.copyWith(
                    email: null,
                    phone: phone,
                    password: form.password,
                    retypedPassword: form.retypedPassword,
                  ),
                );
          },
        ).animate().slideIn(0),
        EESUpTextFormField(
          isPassword: true,
          label: 'Password',
          initialValue: form.password,
          onChanged: (value) {
            final v = value.isEmpty ? null : value;

            context.read<RegisterCubit>().updateForm(
                  form.copyWith(
                    email: form.email,
                    phone: form.phone,
                    password: v,
                    retypedPassword: form.retypedPassword,
                  ),
                );
          },
        ).animate().slideIn(50),
        PasswordStrength(
          confirmPassword: form.retypedPassword ?? '',
          password: form.password ?? '',
          onValidPassword: (isValid) {
            _isValidPassword = isValid;
          },
        ).animate().slideIn(100),
        EESUpTextFormField(
          isPassword: true,
          initialValue: form.retypedPassword,
          label: 'Confirm Password',
          onChanged: (value) {
            final v = value.isEmpty ? null : value;
            context.read<RegisterCubit>().updateForm(
                  form.copyWith(
                    email: form.email,
                    phone: form.phone,
                    password: form.password,
                    retypedPassword: v,
                  ),
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
        ).animate().slideIn(200)
      ],
    );
  }
}
