import 'package:ui/core/extensions/context_theme_ext.dart';
import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:ui/core/widgets/eesup_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ReferralCodeForm extends StatelessWidget {
  ReferralCodeForm({super.key, required this.tabController});
  final TabController tabController;

  final _codeController = TextEditingController();
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
              controller: _codeController,
              type: TextInputType.number,
              hintText: 'Referral Code',
            ),
            20.sH,
            Row(
              children: [
                Checkbox(
                  visualDensity: VisualDensity.compact,
                  value: false,
                  onChanged: (v) {
                    // updateIsAgreed(ref, v ?? false);
                  },
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'I agree to the EESUp\'s ',
                      style: context.textTheme.displayMedium!.copyWith(
                        color: Colors.grey.shade800,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms of Service',
                          style: context.textTheme.displayMedium!.copyWith(
                            color: context.colorScheme.primary,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // context.push(TermsAndConditionsScreen.route);
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            20.sH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    onPressed: () async {},
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

  String capitalizeFirstLetter(String str) {
    if (str.isEmpty) return str;
    return str[0].toUpperCase() + str.substring(1);
  }
}
