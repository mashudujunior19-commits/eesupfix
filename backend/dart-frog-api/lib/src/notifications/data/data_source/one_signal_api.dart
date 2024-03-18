// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as d_io;
import 'package:eesup_dart_frog/core/env/env_service.dart';
import 'package:eesup_dart_frog/src/notifications/data/models/notification.dart';

class OneSignalApi {
  const OneSignalApi(this.env);
  final EnvService env;

  Future<Either<Exception, bool>> sendNotification(
      Notification notification) async {
    print('notification: $notification');
    final body = {
      'include_aliases': {
        'external_id': [...notification.recipients]
      },
      'target_channel': 'push',
      'contents': {
        'en': notification.body,
      },
      'headings': {'en': notification.title},
      'data': notification.data,
      'small_icon': 'launcher_icon',
      'app_id': env.oneSignalAppId,
      'name': notification.campaign ?? 'Default',
    };

    try {
      final dio = d_io.Dio();
      dio.options.headers['Authorization'] = 'Basic ${env.oneSignalApiKey}';
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Host'] = 'onesignal.com';
      dio.options.headers['Content-Length'] = body.toString().length.toString();

      final json = jsonEncode(body);

      // ignore: inference_failure_on_function_invocation
      final res = await dio.post(
        'https://onesignal.com/api/v1/notifications',
        data: json,
      );

      print(res.statusCode);
      print(res);

      if (res.statusCode != 200) {
        return left(Exception('Error sending notification'));
      }

      return right(true);
    } catch (e) {
      print(e);
      return left(e as Exception);
    }
  }
}
