import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/features/auth/register/bloc/registration_bloc.dart';
import 'package:ui/src/features/auth/register/ui/password_strength.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'email_and_phone_tab_container.dart';

// ignore: must_be_immutable
class CredentialsForm extends StatelessWidget {
  CredentialsForm({
    super.key,
    required this.form,
    required this.tabController,
  });
  final SignUpForm form;
  final TabController tabController;
  bool isValidPassword = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 400),
      children: [
        EmailAndPhoneTabContainer(
          initEmail: form.email,
          initPhone: form.phone,
          onEmailChanged: (email) {
            context.read<RegistrationBloc>().add(
                  SignUpFormUpdated(
                    form.copyWith2(
                      email: email,
                      phone: null,
                    ),
                  ),
                );
          },
          onPhoneChanged: (phone) {
            context.read<RegistrationBloc>().add(
                  SignUpFormUpdated(
                    form.copyWith2(
                      phone: phone,
                      email: null,
                    ),
                  ),
                );
          },
        ).animate().slideIn(0),
        EESUpTextFormField(
          isPassword: true,
          label: 'Password',
          onChanged: (value) {
            final v = value.isEmpty ? null : value;
            context.read<RegistrationBloc>().add(
                  SignUpFormUpdated(form.copyWith(password: v)),
                );
          },
        ).animate().slideIn(50),
        PasswordStrength(
          confirmPassword: form.retypedPassword ?? '',
          password: form.password ?? '',
          onValidPassword: (isValid) {
            isValidPassword = isValid;
          },
        ).animate().slideIn(100),
        EESUpTextFormField(
          isPassword: true,
          label: 'Confirm Password',
          onChanged: (value) {
            final v = value.isEmpty ? null : value;
            context.read<RegistrationBloc>().add(
                  SignUpFormUpdated(form.copyWith(retypedPassword: v)),
                );
          },
        ).animate().slideIn(150),
        30.sH,
        ElevatedButton(
          onPressed: () async {
            FocusScope.of(context).unfocus();

            // print(form.toJson());

            // final tempEmail = form.email ?? '';
            // final tempPhone = form.phone ?? '';

            // if (tempPhone.isEmpty && tempEmail.isEmpty) {
            //   context.snackBarError('Please provide your email or phone');
            //   return;
            // }

            // if (!form.isValidEmail() && tempEmail.isNotEmpty) {
            //   context.snackBarError('Please provide a valid email address');
            //   return;
            // }
          },
          child: const Text('Next'),
        ).animate().slideIn(200)
      ],
    );
  }

  String capitalizeFirstLetter(String str) {
    if (str.isEmpty) return str;
    return str[0].toUpperCase() + str.substring(1);
  }
}
