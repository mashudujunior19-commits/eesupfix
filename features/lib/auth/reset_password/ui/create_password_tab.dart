import 'package:features/auth/register/ui/password_strength.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:features/core/extensions/slide_in_animation_ext.dart';
import 'package:features/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final _passwordController = TextEditingController();

  final _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
        top: 10,
        bottom: 400,
      ),
      children: [
        EESUpTextFormField(
          isPassword: true,
          label: 'Password',
          controller: _passwordController,
          onChanged: (value) => setState(() {}),
        ).animate().slideIn(50),
        PasswordStrength(
          confirmPassword: _confirmController.text,
          password: _passwordController.text,
          onValidPassword: (isValid) {},
        ).animate().slideIn(100),
        EESUpTextFormField(
          isPassword: true,
          label: 'Confirm Password',
          onChanged: (value) => setState(() {}),
          controller: _confirmController,
        ).animate().slideIn(150),
        25.sH,
        ElevatedButton(onPressed: () {}, child: const Text('Submit'))
      ],
    );
  }
}
