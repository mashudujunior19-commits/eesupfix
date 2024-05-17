// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_reaction.freezed.dart';
part 'chat_message_reaction.g.dart';

@freezed
class ChatMessageReaction with _$ChatMessageReaction {
  const factory ChatMessageReaction({
    @JsonKey(name: 'message_id') required int messageId,
    @JsonKey(name: 'member_id') required String memberId,
    @JsonKey(name: 'created_at', includeToJson: false)
    required DateTime createdAt,
    @JsonKey(name: 'member_full_name', includeToJson: false)
    required String memberName,
    required bool liked,
  }) = _ChatMessageReaction;

  factory ChatMessageReaction.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageReactionFromJson(json);
}

class ChatMessageReactionConverter
    implements JsonConverter<ChatMessageReaction, Map<String, dynamic>> {
  const ChatMessageReactionConverter();

  @override
  ChatMessageReaction fromJson(Map<String, dynamic> json) {
    return ChatMessageReaction.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(ChatMessageReaction instance) {
    return instance.toJson();
  }
}
