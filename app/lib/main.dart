import 'package:ui/ui.dart';

Future<void> main() async {
  return bootstrap(
    environment: Flavor(type: Environment.development, app: AppType.eesup),
  );
}
