// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdBannerImpl _$$AdBannerImplFromJson(Map<String, dynamic> json) =>
    _$AdBannerImpl(
      id: json['id'] as int,
      content: (json['content'] as List<dynamic>)
          .map((e) =>
              const AdContentConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AdBannerImplToJson(_$AdBannerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content':
          instance.content.map(const AdContentConverter().toJson).toList(),
    };

_$AdContentImpl _$$AdContentImplFromJson(Map<String, dynamic> json) =>
    _$AdContentImpl(
      url: json['url'] as String,
      type: json['type'] as String,
      orderNumber: json['order_number'] as int,
    );

Map<String, dynamic> _$$AdContentImplToJson(_$AdContentImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'type': instance.type,
      'order_number': instance.orderNumber,
    };
