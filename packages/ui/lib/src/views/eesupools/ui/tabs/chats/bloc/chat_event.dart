part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class ChatStreamStarted extends ChatEvent {
  final int eesupoolId;
  ChatStreamStarted(this.eesupoolId);
}

final class MessageSeenUpdated extends ChatEvent {
  final int messageId;
  final String memberId;
  MessageSeenUpdated(this.messageId, this.memberId);
}

final class MessageReactionAdded extends ChatEvent {
  final int poolId;
  final int messageId;
  final String authorId;
  final bool liked;
  MessageReactionAdded(this.poolId, this.messageId, this.authorId, this.liked);
}

final class ChatStreamStopped extends ChatEvent {
  ChatStreamStopped();
}
