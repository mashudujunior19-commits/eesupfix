// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BasketImpl _$$BasketImplFromJson(Map<String, dynamic> json) => _$BasketImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: _$JsonConverterFromJson<String, BasketType>(
          json['type'], const BasketTypeConverter().fromJson),
    );

Map<String, dynamic> _$$BasketImplToJson(_$BasketImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$JsonConverterToJson<String, BasketType>(
          instance.type, const BasketTypeConverter().toJson),
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
