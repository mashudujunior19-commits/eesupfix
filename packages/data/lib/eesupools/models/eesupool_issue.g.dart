// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eesupool_issue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EESUpoolIssue _$EESUpoolIssueFromJson(Map<String, dynamic> json) =>
    _EESUpoolIssue(
      id: json['issue_id'] as String,
      eesupoolId: (json['eesupool_id'] as num).toInt(),
      parentPoolId: (json['parent_pool_id'] as num?)?.toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      reporterId: json['reporter_id'] as String?,
      offenderId: json['offender_id'] as String?,
      description: json['description'] as String,
      resolvedAt: json['resolved_at'] == null
          ? null
          : DateTime.parse(json['resolved_at'] as String),
      chatMessageId: (json['message_id'] as num?)?.toInt(),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) =>
              const MediaFileConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
      chatMessage: _$JsonConverterFromJson<Map<String, dynamic>, ChatMessage>(
          json['message'], const ChatMessageConverter().fromJson),
      reporter: _$JsonConverterFromJson<Map<String, dynamic>, EESUpoolMember>(
          json['reporter_member'], const EESUpoolMemberConverter().fromJson),
      offender: _$JsonConverterFromJson<Map<String, dynamic>, EESUpoolMember>(
          json['offender_member'], const EESUpoolMemberConverter().fromJson),
    );

Map<String, dynamic> _$EESUpoolIssueToJson(_EESUpoolIssue instance) =>
    <String, dynamic>{
      'eesupool_id': instance.eesupoolId,
      'parent_pool_id': instance.parentPoolId,
      'reporter_id': instance.reporterId,
      'offender_id': instance.offenderId,
      'description': instance.description,
      'resolved_at': instance.resolvedAt?.toIso8601String(),
      'message_id': instance.chatMessageId,
      'attachments':
          instance.attachments?.map(const MediaFileConverter().toJson).toList(),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
