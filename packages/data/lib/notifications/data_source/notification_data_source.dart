import 'package:data/notifications/models/notification.dart';

abstract class NotificationDataSource {
  Stream<List<Notification>> streamNotifications(String userId);
  Future<void> deleteNotification(int id);
}
