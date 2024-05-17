import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';
import 'package:ui/src/features/auth/register/ui/email_and_phone_tab_container.dart';

class CredentialsFormTab extends StatefulWidget {
  const CredentialsFormTab({super.key});

  @override
  State<CredentialsFormTab> createState() => _CredentialsFormTabState();
}

class _CredentialsFormTabState extends State<CredentialsFormTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
        top: 50,
        bottom: 400,
      ),
      children: [
        Text(
          'Don\'t worry! it happens to the best of us.'
          ' Please enter an email address or mobile number '
          'associated with your account and we will send'
          ' you an One-Time-Pin to reset your password.',
          textAlign: TextAlign.center,
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 14.5,
            color: Colors.grey,
          ),
        ),
        EmailAndPhoneTabContainer(
            onEmailChanged: (e) {}, onPhoneChanged: (p) {}),
        25.sH,
        ElevatedButton(onPressed: () {}, child: const Text('Reset'))
      ],
    );
  }
}
