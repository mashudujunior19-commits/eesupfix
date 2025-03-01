// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hamper_banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HamperBanner _$HamperBannerFromJson(Map<String, dynamic> json) =>
    _HamperBanner(
      id: (json['id'] as num).toInt(),
      content: (json['content'] as List<dynamic>)
          .map((e) => const HamperContentConverter()
              .fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HamperBannerToJson(_HamperBanner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content':
          instance.content.map(const HamperContentConverter().toJson).toList(),
    };

_HamperContent _$HamperContentFromJson(Map<String, dynamic> json) =>
    _HamperContent(
      type: json['type'] as String,
      orderNumber: (json['order_number'] as num).toInt(),
      baseImage: json['base_image'] as String,
      gif1: json['gif1'] as String,
      gif2: json['gif2'] as String,
    );

Map<String, dynamic> _$HamperContentToJson(_HamperContent instance) =>
    <String, dynamic>{
      'type': instance.type,
      'order_number': instance.orderNumber,
      'base_image': instance.baseImage,
      'gif1': instance.gif1,
      'gif2': instance.gif2,
    };
