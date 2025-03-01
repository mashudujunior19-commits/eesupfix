// ignore_for_file: invalid_annotation_target

import 'dart:io';

import 'package:data/eesupools/models/chat_message_reaction.dart';
import 'package:data/eesupools/models/eesupool_level.dart';
import 'package:data/eesupools/models/media_file.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

@freezed
abstract class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    @JsonKey(includeToJson: false) required int id,
    @JsonKey(name: 'eesupool_id') required int eesupoolId,
    @JsonKey(name: 'author_id') required String authorId,
    @JsonKey(name: 'created_at', includeToJson: true)
    required DateTime createdAt,
    @JsonKey(name: 'author_full_name', includeToJson: false) String? authorName,
    @JsonKey(name: 'content') String? content,
    @JsonKey(name: 'reply_on_id') int? replyOnId,
    @JsonKey(name: 'attachments') @MediaFileConverter() List<MediaFile>? media,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default([])
    List<File> localFiles,
    @ChatMessageConverter()
    @JsonKey(name: 'reply_message', includeToJson: false)
    ChatMessage? reply,
    @ChatMessageReactionConverter()
    @JsonKey(name: 'reactions', includeToJson: false)
    List<ChatMessageReaction>? reactions,
    @JsonKey(name: 'hash_tags') List<String>? hashTags,
    @JsonKey(name: 'is_approved') required bool isApproved,
    @JsonKey(name: 'is_deleted', includeToJson: false) required bool isDeleted,
    @EESUpoolLevelConverter()
    @JsonKey(name: 'broadcast_to')
    List<EESUpoolLevel>? broadcastTo,
    @JsonKey(name: 'message_seens', includeToJson: false)
    @Default([])
    List<String> messageSeens,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}

class ChatMessageConverter
    implements JsonConverter<ChatMessage, Map<String, dynamic>> {
  const ChatMessageConverter();

  @override
  ChatMessage fromJson(Map<String, dynamic> json) {
    return ChatMessage.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(ChatMessage instance) {
    return instance.toJson();
  }
}
