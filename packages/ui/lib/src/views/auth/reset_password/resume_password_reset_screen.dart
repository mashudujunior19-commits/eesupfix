import 'package:auto_route/auto_route.dart';
import 'package:data/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/views/auth/reset_password/create_password_tab.dart';

/// Shown instead of Home when the app starts up with a leftover
/// password-recovery session -- i.e. the user verified their OTP but the
/// app was closed before they actually set a new password. Lets them
/// finish where they left off (the recovery session is still valid for
/// this) rather than being silently dropped into the app, or losing the
/// reset entirely.
@RoutePage()
class ResumePasswordResetScreen extends StatelessWidget {
  const ResumePasswordResetScreen({super.key, this.email, this.phone});
  final String? email;
  final String? phone;

  @override
  Widget build(BuildContext context) {
    return CreateNewPasswordDialog(
      email: email,
      phone: phone,
      infoBanner: 'You have an unfinished password reset. Set a new '
          'password to continue, or cancel to sign in again.',
      onSuccess: () async {
        // Never let the recovery session itself double as a logged-in
        // session -- require a fresh, intentional sign-in with the new
        // password.
        await context.read<AuthRepository>().signOut();
        if (context.mounted) {
          context.router.replaceAll([const SignInRoute()]);
        }
      },
      onCancel: () async {
        await context.read<AuthRepository>().clearPasswordResetPending();
        await context.read<AuthRepository>().signOut();
        if (context.mounted) {
          context.router.replaceAll([const SignInRoute()]);
        }
      },
    );
  }
}
