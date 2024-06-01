part of 'notifications_bloc.dart';

@immutable
sealed class NotificationsEvent {}


final class NotificationStreamStarted extends NotificationsEvent{}