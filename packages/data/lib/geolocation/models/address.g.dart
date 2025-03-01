// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Address _$AddressFromJson(Map<String, dynamic> json) => _Address(
      id: (json['id'] as num?)?.toInt(),
      areaId: (json['area_id'] as num?)?.toInt(),
      userId: json['user_id'] as String?,
      recipientName: json['recipient_name'] as String,
      recipientPhone: json['recipient_phone'] as String,
      streetAddress: json['street_address'] as String,
      buildingName: json['building_name'] as String?,
      type: json['type'] as String,
      province: json['province'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      isPrimary: json['is_primary'] as bool? ?? false,
    );

Map<String, dynamic> _$AddressToJson(_Address instance) => <String, dynamic>{
      'area_id': instance.areaId,
      'user_id': instance.userId,
      'recipient_name': instance.recipientName,
      'recipient_phone': instance.recipientPhone,
      'street_address': instance.streetAddress,
      'building_name': instance.buildingName,
      'type': instance.type,
      'province': instance.province,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'is_primary': instance.isPrimary,
    };
