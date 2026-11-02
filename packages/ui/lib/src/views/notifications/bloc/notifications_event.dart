part of 'notifications_bloc.dart';

@immutable
sealed class NotificationsEvent {}

final class NotificationStreamStarted extends NotificationsEvent {}

final class MarkNotificationsSeenEvent extends NotificationsEvent {
  final List<int> notificationIds;

  MarkNotificationsSeenEvent(this.notificationIds);
}

/// An invite / join request was answered: record the outcome on its
/// notification right away (the database does the same, this just avoids
/// waiting for the realtime update).
final class NotificationRespondedEvent extends NotificationsEvent {
  final int notificationId;
  final String response;

  NotificationRespondedEvent(this.notificationId, this.response);
}
