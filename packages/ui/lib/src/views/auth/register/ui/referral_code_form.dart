import 'package:auto_route/auto_route.dart';
import 'package:data/auth/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_highlighted_text/flutter_highlighted_text.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/app_route.gr.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';
import 'package:ui/src/views/auth/register/cubit/register_cubit.dart';
import 'package:ui/src/views/auth/register/cubit/register_form.dart';

class ReferralCodeForm extends StatefulWidget {
  const ReferralCodeForm({
    super.key,
    required this.form,
    required this.tabController,
  });
  final RegisterForm form;
  final TabController tabController;

  @override
  State<ReferralCodeForm> createState() => _ReferralCodeFormState();
}

class _ReferralCodeFormState extends State<ReferralCodeForm> {
  bool _isSubmitting = false;

  RegisterForm get form => widget.form;
  TabController get tabController => widget.tabController;

  Future<void> _handleSignUp() async {
    if (_isSubmitting) return;

    FocusScope.of(context).unfocus();

    if (!form.agreedToTcsAndCs) {
      context.snackBarError(
        'Please review our Terms of Service and accept them to continue.',
      );
      return;
    }

    // Validate referral code is positive if provided
    if (form.referralCode != null && form.referralCode! <= 0) {
      context.snackBarError('Invalid referral code.');
      return;
    }

    if (form.referralCode != null) {
      setState(() => _isSubmitting = true);
      context.loaderOverlay.show();

      final results = await context
          .read<AuthRepository>()
          .isValidReferralCode(form.referralCode!);

      if (!mounted) return;
      context.loaderOverlay.hide();

      // Use fold result to determine if we should proceed
      final hasError = results.fold(
        (left) {
          context.snackBarError(left.message);
          return true;
        },
        (right) {
          if (!right.isValid) {
            context.snackBarError('Invalid referral code.');
            return true;
          }
          if (right.isCorporate) {
            context.snackBarError(
              'A corporate account cannot refer other accounts',
            );
            return true;
          }
          return false;
        },
      );

      if (hasError) {
        setState(() => _isSubmitting = false);
        return;
      }
    }

    // Submit registration
    context.read<RegisterCubit>().submit();
    setState(() => _isSubmitting = false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Who referred you?'),
            10.sH,
            EESUpTextFormField(
              type: TextInputType.number,
              hintText: 'Referral Code',
              onChanged: (value) {
                final code = int.tryParse(value);

                context.read<RegisterCubit>().updateForm(
                      form.copyWith(referralCode: code),
                    );
              },
            ),
            20.sH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                  visualDensity: VisualDensity.compact,
                  value: form.agreedToTcsAndCs,
                  onChanged: (v) {
                    context.read<RegisterCubit>().updateForm(
                          form.copyWith(agreedToTcsAndCs: v ?? false),
                        );
                  },
                ),
                Expanded(
                  child: HighlightedText(
                    'I agree to the EESUp\'s Terms of Service',
                    patterns: const ['Terms of Service'],
                    onTap: (p) {
                      if (p == 'Terms of Service') {
                        context.router.push(const TermsOfServiceRoute());
                      }
                    },
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 14,
                    ),
                    highLightStyle: context.textTheme.labelMedium?.copyWith(
                      fontSize: 14,
                      color: context.colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            20.sH,
            ElevatedButton(
              onPressed: _isSubmitting ? null : _handleSignUp,
              child: _isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      form.referralCode != null
                          ? 'Got it, Sign up'
                          : 'No one, Sign up',
                    ),
            )
          ],
        ),
      ],
    );
  }
}
