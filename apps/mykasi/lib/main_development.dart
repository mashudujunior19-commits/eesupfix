import 'package:ui/ui.dart';

///Main function to bootstrap the app
Future<void> main() async {
  return bootstrap(
    environment: Flavor(
      type: FlavorType.development,
      app: AppType.mykasi,
    ),
  );
}
