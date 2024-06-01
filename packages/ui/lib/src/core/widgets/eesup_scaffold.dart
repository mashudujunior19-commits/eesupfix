import 'package:data/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/extensions/slide_in_animation_ext.dart';

class EESUpScaffold extends StatelessWidget {
  const EESUpScaffold({
    super.key,
    this.appBar,
    this.body,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });
  final AppBar? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<String?>(
          future: context.read<AuthRepository>().fetchSystemIssue(),
          builder: (context, snapshot) {
            final message = snapshot.data;
            if (message != null) {
              return Container(
                width: context.width,
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                color: context.colorScheme.primary,
                height: 30,
                child: Center(
                  child: TextScroll(
                    velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
                    message,
                    style: context.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ).animate().slideIn(0);
            } else {
              return 0.sW;
            }
          },
        ),
        Expanded(
          child: Scaffold(
            backgroundColor: backgroundColor,
            appBar: appBar,
            body: body,
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation: floatingActionButtonLocation,
            bottomNavigationBar: bottomNavigationBar,
          ),
        )
      ],
    );
  }
}
