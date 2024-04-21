import 'package:features/auth/register/bloc/registration_bloc.dart';
import 'package:features/auth/register/ui/password_strength.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:int_phone_text_field/int_phone_text_field.dart';
import 'package:repository/utils/localize_south_african_phone.dart';
import 'package:tab_container/tab_container.dart';

// ignore: must_be_immutable
class CredentialsForm extends StatelessWidget {
  CredentialsForm({
    super.key,
    required this.form,
    required this.tabController,
  });
  final SignUpForm form;
  final TabController tabController;
  final _tabController = TabContainerController(length: 2);
  bool isValidPassword = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 400),
      children: [
        SizedBox(
          height: 125,
          child: TabContainer(
            controller: _tabController,
            childPadding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            color: Colors.white,
            radius: 15,
            tabs: const ['Email', 'Phone'],
            children: [
              EESUpTextFormField(
                margin: const EdgeInsets.only(top: 0),
                hintText: 'email@gmail.com',
                initialValue: form.email,
                onChanged: (value) {
                  final v = value.isEmpty ? null : value;
                  context.read<RegistrationBloc>().add(
                        SignUpFormUpdated(form.copyWith(email: v, phone: null)),
                      );
                },
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withOpacity(.03),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: .5,
                  ),
                ),
                child: PhoneTextField(
                  initialCountry: countries.firstWhere(
                    (e) => e.code == 'ZA',
                  ),
                  textStyle: context.textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                  ),
                  onChanged: (value) {
                    final phone = localizeSAPhoneNumber(value);
                    context.read<RegistrationBloc>().add(
                          SignUpFormUpdated(
                              form.copyWith(phone: phone, email: null)),
                        );
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              )
            ],
          ),
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
