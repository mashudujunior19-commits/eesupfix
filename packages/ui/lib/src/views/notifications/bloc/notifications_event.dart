part of 'notifications_bloc.dart';

@immutable
sealed class NotificationsEvent {}

final class NotificationStreamStarted extends NotificationsEvent {}

final class MarkNotificationsSeenEvent extends NotificationsEvent {
  final List<int> notificationIds;

  MarkNotificationsSeenEvent(this.notificationIds);
}
