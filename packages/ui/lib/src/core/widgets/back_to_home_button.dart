import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/app_route.gr.dart';

/// Takes the user back to the Home screen, whichever way they got here (the
/// menu, a home shortcut, a deep link or a notification). If Home is already in
/// the navigation stack it goes back to it; if not (a deep link or a
/// notification can open this screen on its own) Home is put in place.
///
/// The device's own back button is untouched and still returns to the previous
/// screen.
void goToHome(BuildContext context) {
  final root = context.router.root;
  final homeIsInStack = root.stack.any(
    (page) => page.routeData.name == OverviewRoute.name,
  );
  if (homeIsInStack) {
    root.popUntilRouteWithName(OverviewRoute.name);
  } else {
    root.replaceAll([const OverviewRoute()]);
  }
}

/// A top-left back arrow labelled "Back to Home" for screens' app bars.
class BackToHomeButton extends StatelessWidget {
  const BackToHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ios = defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS;
    return IconButton(
      tooltip: 'Back to Home',
      icon: Icon(ios ? Icons.arrow_back_ios_new : Icons.arrow_back),
      onPressed: () => goToHome(context),
    );
  }
}
