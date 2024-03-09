// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionImpl _$$TransactionImplFromJson(Map<String, dynamic> json) =>
    _$TransactionImpl(
      id: json['id'] as int,
      type: json['type'] as String,
      docRef: json['doc_ref'] as int,
      value: (json['value'] as num).toDouble(),
      vested: json['vested'] as bool,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      confirmedAt: json['confirmed_at'] == null
          ? null
          : DateTime.parse(json['confirmed_at'] as String),
      cancelledAt: json['cancelled_at'] == null
          ? null
          : DateTime.parse(json['cancelled_at'] as String),
    );

Map<String, dynamic> _$$TransactionImplToJson(_$TransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'doc_ref': instance.docRef,
      'value': instance.value,
      'vested': instance.vested,
      'description': instance.description,
      'created_at': instance.createdAt.toIso8601String(),
      'confirmed_at': instance.confirmedAt?.toIso8601String(),
      'cancelled_at': instance.cancelledAt?.toIso8601String(),
    };
