part of 'notifications_bloc.dart';

@immutable
sealed class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}

final class NotificationsError extends NotificationsState {
  final EESUpException err;
  NotificationsError(this.err);
}

final class NotificationsStreaming extends NotificationsState {
  final List<Notification> notifications;
  NotificationsStreaming(this.notifications);
}
