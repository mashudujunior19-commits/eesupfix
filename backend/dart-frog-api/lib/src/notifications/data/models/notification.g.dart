// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationImpl _$$NotificationImplFromJson(Map<String, dynamic> json) =>
    _$NotificationImpl(
      body: json['body'] as String,
      recipients: (json['recipients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      title: json['title'] as String?,
      campaign: json['campaign'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$$NotificationImplToJson(_$NotificationImpl instance) =>
    <String, dynamic>{
      'body': instance.body,
      'recipients': instance.recipients,
      'title': instance.title,
      'campaign': instance.campaign,
      'data': instance.data,
      'image_url': instance.imageUrl,
    };
