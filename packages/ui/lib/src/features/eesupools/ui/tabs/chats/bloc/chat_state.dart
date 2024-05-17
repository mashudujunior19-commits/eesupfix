part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatMessagesLoaded extends ChatState {
  final List<ChatMessage> chats;
  ChatMessagesLoaded(this.chats);
}

final class ChatsError extends ChatState {
  final EESUpException error;
  ChatsError(this.error);
}
