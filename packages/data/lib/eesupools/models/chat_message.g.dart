// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      id: json['id'] as int,
      eesupoolId: json['eesupool_id'] as int,
      authorId: json['author_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      authorName: json['author_full_name'] as String?,
      content: json['content'] as String?,
      replyOnId: json['reply_on_id'] as int?,
      media: (json['attachments'] as List<dynamic>?)
          ?.map((e) =>
              const MediaFileConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
      reply: _$JsonConverterFromJson<Map<String, dynamic>, ChatMessage>(
          json['reply_message'], const ChatMessageConverter().fromJson),
      reactions: (json['reactions'] as List<dynamic>?)
          ?.map((e) => const ChatMessageReactionConverter()
              .fromJson(e as Map<String, dynamic>))
          .toList(),
      hashTags: (json['hash_tags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isApproved: json['is_approved'] as bool,
      isDeleted: json['is_deleted'] as bool,
      broadcastTo: (json['broadcast_to'] as List<dynamic>?)
          ?.map((e) => const EESUpoolLevelConverter().fromJson(e as String))
          .toList(),
      messageSeens: (json['message_seens'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'eesupool_id': instance.eesupoolId,
      'author_id': instance.authorId,
      'created_at': instance.createdAt.toIso8601String(),
      'content': instance.content,
      'reply_on_id': instance.replyOnId,
      'attachments':
          instance.media?.map(const MediaFileConverter().toJson).toList(),
      'hash_tags': instance.hashTags,
      'is_approved': instance.isApproved,
      'broadcast_to': instance.broadcastTo
          ?.map(const EESUpoolLevelConverter().toJson)
          .toList(),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
