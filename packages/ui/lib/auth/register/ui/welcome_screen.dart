import 'package:ui/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: Image.asset('assets/images/logo.png'),
            ),
          ],
        ),
        15.sH,
        Text(
          'Welcome!! 🎉🎉🎉',
          style: TextStyle(
            color: Colors.grey.shade900,
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
        10.sH,
        Text(
          'Welcome to the EESUp family. We are excited to have you on board.',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 20),
          child: ElevatedButton(
            child: const Text('Get Started'),
            onPressed: () {
              // if (ref.read(authRepoProvider).sessionId != null) {
              //   ref.read(profileProvider.notifier).fetchProfile();
              //   context.pushReplacement(HomeScreen.route);
              // } else {
              //   context.pushReplacement(SignInScreen.route);
              // }
            },
          ),
        ),
      ],
    );
  }
}
