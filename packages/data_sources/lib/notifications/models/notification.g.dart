// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationImpl _$$NotificationImplFromJson(Map<String, dynamic> json) =>
    _$NotificationImpl(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      type: const NotificationTypeConveter().fromJson(json['type'] as String),
      data: _$JsonConverterFromJson<Map<String, dynamic>, NotificationData>(
          json['data'], const NotificationDataConveter().fromJson),
    );

Map<String, dynamic> _$$NotificationImplToJson(_$NotificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'created_at': instance.createdAt.toIso8601String(),
      'type': const NotificationTypeConveter().toJson(instance.type),
      'data': _$JsonConverterToJson<Map<String, dynamic>, NotificationData>(
          instance.data, const NotificationDataConveter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
