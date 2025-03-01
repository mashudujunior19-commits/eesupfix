// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdBanner _$AdBannerFromJson(Map<String, dynamic> json) => _AdBanner(
      id: (json['id'] as num).toInt(),
      content: (json['content'] as List<dynamic>)
          .map((e) =>
              const AdContentConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdBannerToJson(_AdBanner instance) => <String, dynamic>{
      'id': instance.id,
      'content':
          instance.content.map(const AdContentConverter().toJson).toList(),
    };

_AdContent _$AdContentFromJson(Map<String, dynamic> json) => _AdContent(
      url: json['url'] as String,
      type: json['type'] as String,
      orderNumber: (json['order_number'] as num).toInt(),
    );

Map<String, dynamic> _$AdContentToJson(_AdContent instance) =>
    <String, dynamic>{
      'url': instance.url,
      'type': instance.type,
      'order_number': instance.orderNumber,
    };
