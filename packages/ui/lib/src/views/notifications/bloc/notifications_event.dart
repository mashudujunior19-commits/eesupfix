part of 'notifications_bloc.dart';

@immutable
sealed class NotificationsEvent {}

final class NotificationStreamStarted extends NotificationsEvent {}

final class RemoveNotificationEvent extends NotificationsEvent {
  final int notificationId;

  RemoveNotificationEvent(this.notificationId);
}
