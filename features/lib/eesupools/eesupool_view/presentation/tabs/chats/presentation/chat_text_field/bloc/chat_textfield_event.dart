part of 'chat_textfield_bloc.dart';

@immutable
sealed class ChatTextFieldEvent {}


class ChatAttachmentsUploaded extends ChatTextFieldEvent {
  final List<File> files;
  ChatAttachmentsUploaded(this.files);
}

class ChatAttachmentsPicked extends ChatTextFieldEvent {
  final List<File> files;
  ChatAttachmentsPicked(this.files);
}

class ChatMessageSent extends ChatTextFieldEvent {
  final String text;
  final EESUpool pool;
  final List<EESUpoolLevel>? broadcastTo;
  ChatMessageSent(this.pool,this.text, this.broadcastTo);
}

class ChatMessageReplyToAdded extends ChatTextFieldEvent {
  final ChatMessage message;
  ChatMessageReplyToAdded(this.message);
}
