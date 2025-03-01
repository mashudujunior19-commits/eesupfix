// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eesupreneur.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EESUpreneur _$EESUpreneurFromJson(Map<String, dynamic> json) => _EESUpreneur(
      id: json['id'] as String,
      ownerName: json['owner_name'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      ownerId: json['owner_id'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      deliveryFee: (json['delivery_fee'] as num?)?.toDouble(),
      isHidden: json['is_hidden'] as bool?,
      isActive: json['is_active'] as bool?,
      address: _$JsonConverterFromJson<Map<String, dynamic>, Address>(
          json['address'], const AddressConverter().fromJson),
      distance: (json['distance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$EESUpreneurToJson(_EESUpreneur instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'delivery_fee': instance.deliveryFee,
      'is_hidden': instance.isHidden,
      'is_active': instance.isActive,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
