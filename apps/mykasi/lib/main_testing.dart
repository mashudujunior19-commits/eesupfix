import 'package:ui/boostrap.dart';
import 'package:ui/config.dart';
import 'package:ui/core/env/app_type.dart';
import 'package:ui/core/env/flavor_type.dart';

///Main function to bootstrap the app
Future<void> main() async {
  return bootstrap(
    environment: Flavor(
      type: FlavorType.test,
      app: AppType.mykasi,
    ),
  );
}
