import 'package:features/boostrap.dart';
import 'package:features/config.dart';
import 'package:features/core/env/app_type.dart';
import 'package:features/core/env/flavor_type.dart';

///Main function to bootstrap the app
Future<void> main() async {
  return bootstrap(
    environment: Flavor(
      type: FlavorType.production,
      app: AppType.eesup,
    ),
  );
}
