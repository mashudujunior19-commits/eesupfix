import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:eesup_dart_frog/src/notifications/data/data_source/one_signal_api.dart';
import 'package:eesup_dart_frog/src/notifications/data/models/notification.dart';

class NotificationRepository {
  const NotificationRepository(this._api);
  final OneSignalApi _api;

  Future<Response> sendNotification(dynamic body) async {
    try {
      final j = body as Map<String, dynamic>;
      final notifiation = Notification.fromJson(j);

      final response = await _api.sendNotification(notifiation);

      return response.fold(
        (l) {
          return Response.json(
            statusCode: HttpStatus.badRequest,
            body: {
              'message': l.toString(),
            },
          );
        },
        (r) {
          return Response.json(
            body: {
              'message': 'Notification sent successfully',
            },
          );
        },
      );
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {
          'message': 'Error sending notification',
        },
      );
    }
  }
}
