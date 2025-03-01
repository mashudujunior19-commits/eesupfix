// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_gateway.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentGateway _$PaymentGatewayFromJson(Map<String, dynamic> json) =>
    _PaymentGateway(
      id: const PaymentMethodConverter().fromJson(json['id'] as String),
      isActive: json['is_active'] as bool,
      fee: (json['fee'] as num).toDouble(),
    );

Map<String, dynamic> _$PaymentGatewayToJson(_PaymentGateway instance) =>
    <String, dynamic>{
      'id': const PaymentMethodConverter().toJson(instance.id),
      'is_active': instance.isActive,
      'fee': instance.fee,
    };
