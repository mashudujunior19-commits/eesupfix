import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:repository/utils/eesup_exception.dart';
import 'package:features/core/extensions/context_theme_ext.dart';
import 'package:features/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';

class FullScreenError extends StatelessWidget {
  const FullScreenError({
    super.key,
    this.isError = true,
    required this.exception,
    this.showPopButton = false,
  });
  final bool showPopButton;
  final bool isError;
  final Exception exception;

  EESUpException decodeException() {
    try {
      return exception as EESUpException;
    } catch (e) {
      return EESUpException(
        message: 'We encountered an error, please try again',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showPopButton) const BackButton(),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  !isError ? BootstrapIcons.emoji_smile : Icons.error_outline,
                  color: !isError
                      ? Colors.grey
                      : context.colorScheme.error.withOpacity(.4),
                ),
                5.sH,
                Text(
                  decodeException().message,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: !isError
                        ? Colors.grey
                        : context.colorScheme.error.withOpacity(.4),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
