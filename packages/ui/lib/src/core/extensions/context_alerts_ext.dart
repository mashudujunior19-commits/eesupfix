import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/snack_bar.dart';
import 'package:flutter/material.dart';

/// Extension on BuildContext to get height and width of the screen
extension ContextAlertsExt on BuildContext {
  ///show snack bar
  void snackBarSuccess(String message) =>
      showSnackBar(context: this, message: message, type: SnackBarType.success);

  void snackBarError(String message) =>
      showSnackBar(context: this, message: message, type: SnackBarType.error);

  void snackBarWarning(String message) =>
      showSnackBar(context: this, message: message, type: SnackBarType.error);

  Future<bool?> showAlertDialog(
    String title,
    String content, {
    String? positiveText,
    String? negativeText,
    Function()? onPositive,
    Function? onNegative,
    Color? positiveColor,
    Color? negativeColor,
  }) {
    return showPlatformDialog<bool?>(
      context: this,
      builder: (context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          titleTextStyle: textTheme.labelMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(title),
          content: Text(content),
          actions: [
            if (negativeText != null)
              TextButton(
                onPressed: () {
                  onNegative?.call();
                  Navigator.pop(context);
                },
                child: Text(
                  negativeText,
                  style: TextStyle(color: negativeColor ?? colorScheme.error),
                ),
              ),
            15.sW,
            if (positiveText != null)
              TextButton(
                onPressed: () {
                  onPositive?.call();
                  Navigator.pop(context);
                },
                child: Text(
                  positiveText,
                  style: TextStyle(color: positiveColor ?? colorScheme.primary),
                ),
              ),
          ],
        );
      },
    );
  }
}
