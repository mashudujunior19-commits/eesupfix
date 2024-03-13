import 'package:eesup_repository/utils/eesup_exception.dart';
import 'package:eesup_ui_library/core/extensions/context_theme_ext.dart';
import 'package:eesup_ui_library/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';

class LargeErrorWidget extends StatelessWidget {
  const LargeErrorWidget({
    super.key,
    required this.exception,
  });
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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: context.colorScheme.error.withOpacity(.4),
          ),
          5.sH,
          Text(
            decodeException().message,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.error.withOpacity(.4),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
