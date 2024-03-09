// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eesupool_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EESUpoolEventImpl _$$EESUpoolEventImplFromJson(Map<String, dynamic> json) =>
    _$EESUpoolEventImpl(
      id: json['id'] as String,
      eesupoolId: json['eesupool_id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      title: json['title'] as String,
      notes: json['notes'] as String?,
      addressId: json['address_id'] as int?,
      startAt: DateTime.parse(json['start_at'] as String),
      endAt: DateTime.parse(json['end_at'] as String),
      attendees: (json['attendees'] as List<dynamic>?)
          ?.map((e) => const EESUpoolMemberConverter()
              .fromJson(e as Map<String, dynamic>))
          .toList(),
      remoteUrl: json['remote_url'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) =>
              const MediaFileConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$EESUpoolEventImplToJson(_$EESUpoolEventImpl instance) =>
    <String, dynamic>{
      'eesupool_id': instance.eesupoolId,
      'title': instance.title,
      'notes': instance.notes,
      'address_id': instance.addressId,
      'start_at': instance.startAt.toIso8601String(),
      'end_at': instance.endAt.toIso8601String(),
      'remote_url': instance.remoteUrl,
      'attachments':
          instance.attachments?.map(const MediaFileConverter().toJson).toList(),
    };
