import 'package:auto_route/auto_route.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/features/auth/reset_password/create_password_tab.dart';
import 'package:flutter/material.dart';
import 'package:ui/src/features/auth/reset_password/credentials_form_tab.dart';

@RoutePage()
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text('Reset password'),
        ),
        body: Container(
          decoration: context.bgImage,
          height: context.height,
          width: context.width,
          child: TabBarView(
            controller: _controller,
            children: [
              CredentialsFormTab(tabController: _controller),
              CreateNewPassword()
            ],
          ),
        ),
      ),
    );
  }
}
