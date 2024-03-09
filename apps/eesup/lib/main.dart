import 'package:eesup_ui_library/boostrap.dart';
import 'package:eesup_ui_library/config.dart';
import 'package:eesup_ui_library/env/app_type.dart';
import 'package:eesup_ui_library/env/environment_type.dart';

///Main function to bootstrap the app
Future<void> main(List<String> args) async {
  return bootstrap(
    environment: AppEnvironment(
      type: EnvironmentType.test,
      app: AppType.eesup,
    ),
  );
}
