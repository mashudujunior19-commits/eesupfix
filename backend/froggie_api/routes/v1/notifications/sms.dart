import 'package:dart_frog/dart_frog.dart';
import 'package:eesup_dart_frog/core/env/env_service.dart';
import 'package:eesup_dart_frog/src/notifications/data/providers/one_signal_api.dart';
import 'package:eesup_dart_frog/src/notifications/repositories/notification_repository.dart';
import 'package:get_it/get_it.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;
  final body = await request.json();
  final env = GetIt.I.get<EnvService>();
  final repo = NotificationRepository(OneSignalApi(env));
  final response = await repo.sendPush(body);
  return response;
}
