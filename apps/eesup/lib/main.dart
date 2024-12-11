import 'package:ui/ui.dart';

Future<void> main() async {
  return bootstrap(
    environment: Flavor(
      type: FlavorType.production,
      app: AppType.eesup,
    ),
  );
}
