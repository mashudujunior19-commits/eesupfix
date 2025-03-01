// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Voucher _$VoucherFromJson(Map<String, dynamic> json) => _Voucher(
      userId: json['user_id'] as String?,
      parameterId: json['parameter_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      balance: (json['balance'] as num).toDouble(),
      value: (json['value'] as num).toDouble(),
      id: (json['id'] as num?)?.toInt(),
      cycle: const VoucherCycleConverter().fromJson(json['cycle'] as String),
      period: (json['period'] as num).toInt(),
      endDate: DateTime.parse(json['end_date'] as String),
      confirmedAt: json['confirmed_at'] == null
          ? null
          : DateTime.parse(json['confirmed_at'] as String),
    );

Map<String, dynamic> _$VoucherToJson(_Voucher instance) => <String, dynamic>{
      'user_id': instance.userId,
      'parameter_id': instance.parameterId,
      'created_at': instance.createdAt.toIso8601String(),
      'balance': instance.balance,
      'value': instance.value,
      'id': instance.id,
      'cycle': const VoucherCycleConverter().toJson(instance.cycle),
      'period': instance.period,
      'end_date': instance.endDate.toIso8601String(),
      'confirmed_at': instance.confirmedAt?.toIso8601String(),
    };
