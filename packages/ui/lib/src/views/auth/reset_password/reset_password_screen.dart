import 'package:auto_route/auto_route.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:ui/src/views/auth/reset_password/credentials_form_tab.dart';

@RoutePage()
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text('Reset password'),
        ),
        body: Container(
          decoration: context.bgImage,
          height: context.height,
          width: context.width,
          child: const CredentialsFormTab(),
        ),
      ),
    );
  }
}
