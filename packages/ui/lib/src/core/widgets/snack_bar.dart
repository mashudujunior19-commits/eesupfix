import 'package:flutter/material.dart';

enum SnackBarType { success, error }

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
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
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
}
