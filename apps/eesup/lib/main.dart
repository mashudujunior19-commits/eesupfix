import 'package:eesup/boostrap.dart';
import 'package:eesup/src/env/environment_type.dart';
// ignore: depend_on_referenced_packages


///Main function to bootstrap the app
Future<void> main(List<String> args) async {

  return bootstrap(env: EnvironmentType.test);
}
