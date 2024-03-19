part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class ChatStreamStarted extends ChatEvent {
  final int eesupoolId;
  ChatStreamStarted(this.eesupoolId);
}

final class ChatStreamStopped extends ChatEvent {
  ChatStreamStopped();
}
