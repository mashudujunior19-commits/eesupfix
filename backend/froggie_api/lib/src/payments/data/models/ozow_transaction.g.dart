// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ozow_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OzowTransactionImpl _$$OzowTransactionImplFromJson(
        Map<String, dynamic> json) =>
    _$OzowTransactionImpl(
      transactionId: json['transactionId'] as String?,
      merchantCode: json['merchantCode'] as String?,
      siteCode: json['siteCode'] as String?,
      transactionReference: json['transactionReference'] as String?,
      currencyCode: json['currencyCode'] as String?,
      statusMessage: json['statusMessage'] as String?,
      subStatus: json['subStatus'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      paymentDate: json['paymentDate'] == null
          ? null
          : DateTime.parse(json['paymentDate'] as String),
      bankName: json['bankName'] as String?,
      maskedAccountNumber: json['maskedAccountNumber'] as String?,
      smartIndicators: json['smartIndicators'] as String?,
      toBankName: json['toBankName'] as String?,
      toAccountNumber: json['toAccountNumber'] as String?,
      status: _$JsonConverterFromJson<String, OzowStatus>(
          json['status'], const OzowStatusConverter().fromJson),
      amount: (json['amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$OzowTransactionImplToJson(
        _$OzowTransactionImpl instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'merchantCode': instance.merchantCode,
      'siteCode': instance.siteCode,
      'transactionReference': instance.transactionReference,
      'currencyCode': instance.currencyCode,
      'statusMessage': instance.statusMessage,
      'subStatus': instance.subStatus,
      'createdDate': instance.createdDate?.toIso8601String(),
      'paymentDate': instance.paymentDate?.toIso8601String(),
      'bankName': instance.bankName,
      'maskedAccountNumber': instance.maskedAccountNumber,
      'smartIndicators': instance.smartIndicators,
      'toBankName': instance.toBankName,
      'toAccountNumber': instance.toAccountNumber,
      'status': _$JsonConverterToJson<String, OzowStatus>(
          instance.status, const OzowStatusConverter().toJson),
      'amount': instance.amount,
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
