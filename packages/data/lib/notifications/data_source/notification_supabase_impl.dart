import 'package:data/notifications/data_source/notification_data_source.dart';
import 'package:data/notifications/models/notification.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationSupabaseImpl implements NotificationDataSource {
  final SupabaseClient _client;

  NotificationSupabaseImpl(this._client);

  @override
  Stream<List<Notification>> streamNotifications(String userId) async* {
    final stream = _client
        .schema('engagements')
        .from('notification')
        .stream(primaryKey: ['id']).eq(
      'user_id',
      userId,
    );
    await for (final event in stream) {
      print(event);
      final notifications = event.map((e) => Notification.fromJson(e)).toList();
      yield notifications;
    }
  }

  @override
  Future<void> deleteNotification(int id) async {
    await _client
        .schema('engagements')
        .from('notification')
        .delete()
        .eq('id', id);
  }
}
