// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hamper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HamperImpl _$$HamperImplFromJson(Map<String, dynamic> json) => _$HamperImpl(
      id: json['id'] as String,
      hamperCode: json['code'] as String,
      hamperName: json['name'] as String,
      type: json['type'] as String,
      value: (json['value'] as num).toDouble(),
      expiryDate: DateTime.parse(json['expiry_date'] as String),
      isFinal: json['is_final'] as bool,
      productIds: (json['productIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      imgUrl: json['img_url'] as String?,
      isFree: json['isFree'] as bool?,
      quantity: (json['quantity'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(int.parse(k), (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$$HamperImplToJson(_$HamperImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.hamperCode,
      'name': instance.hamperName,
      'type': instance.type,
      'value': instance.value,
      'expiry_date': instance.expiryDate.toIso8601String(),
      'is_final': instance.isFinal,
      'productIds': instance.productIds,
      'img_url': instance.imgUrl,
      'isFree': instance.isFree,
      'quantity': instance.quantity?.map((k, e) => MapEntry(k.toString(), e)),
    };
