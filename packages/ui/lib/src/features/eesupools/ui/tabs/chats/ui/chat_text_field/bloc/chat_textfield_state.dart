part of 'chat_textfield_bloc.dart';

@immutable
sealed class ChatTextFieldState {}

final class ChatTextFieldCurrentState extends ChatTextFieldState {
  final List<File> files;
  final ChatMessage? replyTo;
  ChatTextFieldCurrentState(this.files, this.replyTo);
}

final class ChatLoading extends ChatTextFieldState {}

final class ChatTextFieldError extends ChatTextFieldState {
  final EESUpException exception;
  ChatTextFieldError(this.exception);
}
