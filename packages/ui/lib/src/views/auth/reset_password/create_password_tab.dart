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
  const CreateNewPasswordDialog({
    super.key,
    this.email,
    this.phone,
    this.onSuccess,
    this.onCancel,
    this.infoBanner,
  });
  final String? email;
  final String? phone;

  /// Optional explanatory text shown above the form (e.g. explaining why
  /// the user has landed directly on this screen when resuming an
  /// interrupted reset).
  final String? infoBanner;

  /// Called instead of the default double-pop once the password is
  /// updated -- used when this is shown as a standalone screen (resuming
  /// an interrupted reset) rather than as a dialog stacked on top of the
  /// reset-password flow.
  final Future<void> Function()? onSuccess;

  /// When set, replaces the default back button with a close action that
  /// calls this instead of popping -- there's nothing to pop back to when
  /// this is shown as a standalone resumed-reset screen.
  final Future<void> Function()? onCancel;

  @override
  State<CreateNewPasswordDialog> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPasswordDialog> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_isSubmitting) return;

    final password = _passwordController.text;
    final confirm = _confirmController.text;
    if (!PasswordRules.isValid(password, confirm)) {
      context.snackBarError(PasswordRules.errorMessage(password, confirm));
      return;
    }

    setState(() => _isSubmitting = true);
    context.loaderOverlay.show();

    final res = await context.read<AuthRepository>().updatePassword(
          _passwordController.text,
          email: widget.email,
          phone: widget.phone,
        );

    if (!mounted) return;
    context.loaderOverlay.hide();
    setState(() => _isSubmitting = false);

    res.fold((l) {
      context.snackBarError(l.message);
    }, (r) {
      if (r) {
        context.snackBarSuccess(
          'Password reset, you can now sign in with your new password',
        );
        if (widget.onSuccess != null) {
          widget.onSuccess!();
        } else {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      } else {
        context.snackBarError(
          'Failed to update password. Please try again.',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          leading: widget.onCancel != null
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => widget.onCancel!(),
                )
              : const BackButton(),
          title: const Text('Create new password'),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 10,
              bottom: 400,
            ),
            children: [
              if (widget.infoBanner != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    widget.infoBanner!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ),
              EESUpTextFormField(
                isPassword: true,
                label: 'Password',
                controller: _passwordController,
                onChanged: (value) => setState(() {}),
                footer: PasswordRequirements(
                  password: _passwordController.text,
                ),
              ).animate().slideIn(50),
              EESUpTextFormField(
                isPassword: true,
                label: 'Confirm Password',
                onChanged: (value) => setState(() {}),
                controller: _confirmController,
                footer: PasswordsMatchIndicator(
                  password: _passwordController.text,
                  confirmPassword: _confirmController.text,
                ),
              ).animate().slideIn(150),
              25.sH,
              ElevatedButton(
                onPressed: _isSubmitting ? null : _handleSubmit,
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
