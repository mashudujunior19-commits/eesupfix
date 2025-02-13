// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hamper_banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HamperContentImpl _$$HamperContentImplFromJson(Map<String, dynamic> json) =>
    _$HamperContentImpl(
      orderNumber: (json['orderNumber'] as num).toInt(),
      baseImage: json['baseImage'] as String,
      gif1: json['gif1'] as String,
      gif2: json['gif2'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$$HamperContentImplToJson(_$HamperContentImpl instance) =>
    <String, dynamic>{
      'orderNumber': instance.orderNumber,
      'baseImage': instance.baseImage,
      'gif1': instance.gif1,
      'gif2': instance.gif2,
      'type': instance.type,
    };
