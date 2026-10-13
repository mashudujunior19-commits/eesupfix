part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatMessagesLoaded extends ChatState {
  final List<ChatMessage> chats;

  /// Messages the user just sent that the server has not listed yet, oldest
  /// first.
  final List<PendingChatMessage> pending;

  /// One-shot info for the UI (e.g. "held for review"); null on later states.
  final String? notice;
  ChatMessagesLoaded(this.chats, {this.pending = const [], this.notice});
}

final class ChatsError extends ChatState {
  final EESUpException error;
  ChatsError(this.error);
}
