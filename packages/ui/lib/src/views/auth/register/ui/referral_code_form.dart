// ignore_for_file: use_build_context_synchronously

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
import 'package:ui/src/views/auth/register/bloc/registration_bloc.dart';
import 'package:flutter/material.dart';

class ReferralCodeForm extends StatelessWidget {
  const ReferralCodeForm({
    super.key,
    required this.form,
    required this.tabController,
  });
  final SignUpForm form;
  final TabController tabController;

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

                context.read<RegistrationBloc>().add(
                      ReferralCodeUpdated(
                        code: code,
                        acceptedTsAndCs: form.agreedToTcsAndCs,
                      ),
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
                    context.read<RegistrationBloc>().add(
                          ReferralCodeUpdated(
                            code: form.referralCode,
                            acceptedTsAndCs: v ?? false,
                          ),
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
              onPressed: () async {
                FocusScope.of(context).unfocus();
                if (!form.agreedToTcsAndCs) {
                  context.snackBarError(
                    'Please review our Terms of Service and accept them to continue.',
                  );
                  return;
                }
                if (form.referralCode != null) {
                  context.loaderOverlay.show();
                  final results =
                      await context.read<AuthRepository>().isValidReferralCode(
                            form.referralCode!,
                          );
                  context.loaderOverlay.hide();
                  ({bool isValid, bool isCorporate})? res;
                  results.fold((left) {
                    context.snackBarError(left.message);
                    return;
                  }, (right) {
                    res = right;
                  });

                  if (res?.isValid == false) {
                    context.snackBarError('Invalid referral code.');
                    return;
                  }

                  if (res?.isCorporate == true) {
                    context.snackBarError(
                        'A corporate account cannot refer other accounts');
                    return;
                  }
                }

                // print(form.toJson());

                context.read<RegistrationBloc>().add(SignUpSubmited(form));
              },
              child: Text(form.referralCode != null
                  ? 'Got it, Sign up'
                  : 'No one, Sign up'),
            )
          ],
        ),
      ],
    );
  }
}
