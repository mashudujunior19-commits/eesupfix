part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class ChatStreamStarted extends ChatEvent {
  final int eesupoolId;
  ChatStreamStarted(this.eesupoolId);
}

/// One-off re-fetch (after a send, reaction, delete...). Never starts a second
/// realtime stream.
final class ChatRefreshRequested extends ChatEvent {
  final int poolId;
  ChatRefreshRequested(this.poolId);
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

final class MessageDeleted extends ChatEvent {
  final int poolId;
  final int messageId;
  MessageDeleted(this.poolId, this.messageId);
}

/// A reviewer pulls an already delivered message back into the review queue.
final class MessageFlagged extends ChatEvent {
  final int poolId;
  final int messageId;
  MessageFlagged(this.poolId, this.messageId);
}

/// The user pressed send. The message is shown immediately as "sending".
final class ChatMessageSendRequested extends ChatEvent {
  final EESUpool pool;
  final String text;
  final List<File> files;
  final ChatMessage? replyTo;
  final List<EESUpoolLevel>? broadcastTo;
  ChatMessageSendRequested({
    required this.pool,
    required this.text,
    this.files = const [],
    this.replyTo,
    this.broadcastTo,
  });
}

final class ChatMessageRetried extends ChatEvent {
  final String localId;
  ChatMessageRetried(this.localId);
}

/// Removes a message that failed to send.
final class ChatPendingDismissed extends ChatEvent {
  final String localId;
  ChatPendingDismissed(this.localId);
}
