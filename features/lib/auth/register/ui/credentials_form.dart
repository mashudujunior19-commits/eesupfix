// ignore_for_file: use_build_context_synchronously
import 'package:features/auth/register/ui/password_strength.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:int_phone_text_field/int_phone_text_field.dart';
import 'package:tab_container/tab_container.dart';

// ignore: must_be_immutable
class CredentialsForm extends StatelessWidget {
  CredentialsForm({super.key, required this.tabController});
  final TabController tabController;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  String _phone = '';
  final _tabController = TabContainerController(length: 2);
  bool isValidPassword = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

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
            tabs: const [
              'Email',
              'Phone',
            ],
            children: [
              EESUpTextFormField(
                margin: const EdgeInsets.only(top: 0),
                controller: _emailController,
                hintText: 'email@gmail.com',
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(.03),
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
                  textStyle: textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                  ),
                  onChanged: (value) {
                    // final phone = localizeSAPhoneNumber(value);
                    // if (phone != null) {
                    //   _phone = phone;
                    //   setState(() {});
                    // }
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
          controller: _passwordController,
          onChanged: (value) {},
        ).animate().slideIn(50),
        PasswordStrength(
          confirmPassword: _confirmController.text,
          password: _passwordController.text,
          onValidPassword: (isValid) {
            isValidPassword = isValid;
          },
        ).animate().slideIn(50),
        EESUpTextFormField(
          isPassword: true,
          label: 'Confirm Password',
          onChanged: (value) {},
          controller: _confirmController,
        ).animate().slideIn(50),
        30.sH,
        ElevatedButton(
          onPressed: () async {
            FocusScope.of(context).unfocus();
          },
          child: const Text('Next'),
        )
      ],
    );
  }

  String capitalizeFirstLetter(String str) {
    if (str.isEmpty) return str;
    return str[0].toUpperCase() + str.substring(1);
  }
}
