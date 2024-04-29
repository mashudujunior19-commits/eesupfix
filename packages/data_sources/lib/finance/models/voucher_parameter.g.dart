// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoucherParameterImpl _$$VoucherParameterImplFromJson(
        Map<String, dynamic> json) =>
    _$VoucherParameterImpl(
      id: json['id'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      period: json['period'] as int,
      interest: (json['interest'] as num).toDouble(),
      minimumValue: (json['minimum_value'] as num).toDouble(),
    );

Map<String, dynamic> _$$VoucherParameterImplToJson(
        _$VoucherParameterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'period': instance.period,
      'interest': instance.interest,
      'minimum_value': instance.minimumValue,
    };
