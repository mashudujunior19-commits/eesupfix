import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_highlighted_text/flutter_highlighted_text.dart';
import 'package:ui/auth/register/bloc/registration_bloc.dart';
import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:ui/core/widgets/eesup_form_field.dart';
import 'package:flutter/material.dart';

class ReferralCodeForm extends StatelessWidget {
  ReferralCodeForm({
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
                if (code != null) {
                  context.read<RegistrationBloc>().add(
                        SignUpFormUpdated(form.copyWith(referralCode: code)),
                      );
                }
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
                          SignUpFormUpdated(
                            form.copyWith(
                              agreedToTcsAndCs: v,
                            ),
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
                        print(p);
                        //context.router.push(route)
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text("No one, Sign up"),
                ),
                20.sW,
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      print(form.toJson());
                    },
                    child: const Text(
                      'Got it, Sign up',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
