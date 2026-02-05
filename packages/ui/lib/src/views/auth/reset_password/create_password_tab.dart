import 'package:data/auth/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/views/auth/register/ui/password_strength.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CreateNewPasswordDialog extends StatefulWidget {
  const CreateNewPasswordDialog({super.key, this.email, this.phone});
  final String? email;
  final String? phone;

  @override
  State<CreateNewPasswordDialog> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPasswordDialog> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text('Create new password'),
        ),
        body: ListView(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
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
            ElevatedButton(
              onPressed: () async {
                context.loaderOverlay.show();
                final res = await context.read<AuthRepository>().updatePassword(
                      _passwordController.text,
                      email: widget.email,
                      phone: widget.phone,
                    );
                context.loaderOverlay.hide();
                res.fold((l) {
                  context.snackBarError(l.message);
                }, (r) {
                  if (r) {
                    context.snackBarSuccess(
                      'Password reset, you can now sign in with your new password',
                    );
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  } else {
                    context.snackBarError(
                      'Failed to update password. Please try again.',
                    );
                  }
                });
              },
              child: const Text(
                'Submit',
              ),
            )
          ],
        ),
      ),
    );
  }
}
