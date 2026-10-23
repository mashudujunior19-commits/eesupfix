import 'dart:async';

import 'package:flutter/material.dart';

enum SnackBarType { success, error, warning }

/// Shows a snackbar with the given message
///
/// [context] The context to show the snackbar
///
/// [message] The message to show
///
/// [type] The type of snackbar to show. Defaults to [SnackBarType.success]
void showSnackBar({
  required BuildContext context,
  required String message,
  SnackBarType type = SnackBarType.success,
}) {
  final theme = Theme.of(context);
  final isSucess = type == SnackBarType.success;
  final color = isSucess ? theme.primaryColor : Colors.redAccent;
  final messenger = ScaffoldMessenger.of(context);
  // ScaffoldMessenger queues snackbars by default -- without this, each new
  // message would wait for every earlier one to finish its full duration
  // before even appearing, so a message triggered more than once (e.g.
  // resubmitting a wrong password) looks like it never goes away.
  messenger.clearSnackBars();
  const duration = Duration(seconds: 7);
  final controller = messenger.showSnackBar(
    SnackBar(
      duration: duration,
      // A snackbar with an action stays on screen indefinitely by default
      // (persist defaults to true when there is an action), which is why error
      // messages never went away. Always auto-dismiss.
      persist: false,
      elevation: 10,
      action: SnackBarAction(
        label: 'Ok',
        textColor: Colors.white,
        onPressed: () {},
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: color,
      content: Text(
        message,
        style: theme.textTheme.bodyMedium!.copyWith(
          color: Colors.white,
        ),
      ),
    ),
  );
  // Belt and braces: close it ourselves if the framework keeps it open.
  Timer(duration + const Duration(milliseconds: 300), () {
    try {
      controller.close();
    } catch (_) {}
  });
}
