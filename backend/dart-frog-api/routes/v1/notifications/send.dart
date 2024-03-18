import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:eesup_dart_frog/core/env/env_service.dart';
import 'package:eesup_dart_frog/src/auth/application/auth_services.dart';
import 'package:eesup_dart_frog/src/auth/data/data_source/auth_supabase_impl.dart';
import 'package:eesup_dart_frog/src/notifications/data/data_source/one_signal_api.dart';
import 'package:eesup_dart_frog/src/notifications/notification_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase/supabase.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;
  final params = request.uri.queryParameters;

  final authKey = params['api_key'];

  if (authKey == null) {
    return Response.json(
      statusCode: HttpStatus.unauthorized,
      body: {
        'status': 'error',
        'message': 'Not authorized to access this resource,{invalid api key}',
      },
    );
  }

  final supabase = GetIt.I.get<SupabaseClient>();
  final auth = AuthServices(AuthSupabaseImpl(supabase));
  final authrized = await auth.authorized(key: authKey);

  if (!authrized) {
    return Response.json(
      statusCode: HttpStatus.unauthorized,
      body: {
        'status': 'error',
        'message': 'Not authorized to access this resource,{invalid api key}',
      },
    );
  }

  final body = await request.json();
  final env = GetIt.I.get<EnvService>();
  final repo = NotificationRepository(OneSignalApi(env));
  final response = await repo.sendNotification(body);
  return response;
}
