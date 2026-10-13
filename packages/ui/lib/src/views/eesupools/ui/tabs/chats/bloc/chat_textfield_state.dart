part of 'chat_textfield_bloc.dart';

@immutable
sealed class ChatTextFieldState {}

/// What is currently attached to the message being composed.
final class ChatTextFieldCurrentState extends ChatTextFieldState {
  final List<File> files;
  final ChatMessage? replyTo;
  ChatTextFieldCurrentState(this.files, this.replyTo);
}
