// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_reaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatMessageReaction _$ChatMessageReactionFromJson(Map<String, dynamic> json) =>
    _ChatMessageReaction(
      messageId: (json['message_id'] as num).toInt(),
      memberId: json['member_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      memberName: json['member_full_name'] as String,
      liked: json['liked'] as bool,
    );

Map<String, dynamic> _$ChatMessageReactionToJson(
        _ChatMessageReaction instance) =>
    <String, dynamic>{
      'message_id': instance.messageId,
      'member_id': instance.memberId,
      'liked': instance.liked,
    };
