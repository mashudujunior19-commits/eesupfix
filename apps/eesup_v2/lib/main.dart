import 'package:ui/ui.dart';

Future<void> main() async {
  const envStr = String.fromEnvironment('ENV', defaultValue: '');

  if (envStr.isEmpty) throw Exception('Invalid environment settings');

  final env =
      envStr == 'dev' ? Environment.development : Environment.production;

  // ignore: avoid_print
  print('STARTING APP ON $env');

  return bootstrap(
    environment: Flavor(
      type: env,
      app: AppType.eesup,
    ),
  );
}
