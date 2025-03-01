import 'package:ui/ui.dart';

Future<void> main() async {
  return bootstrap(
    environment: Flavor(
      type: Environment.production,
      app: AppType.eesup,
    ),
  );
}
