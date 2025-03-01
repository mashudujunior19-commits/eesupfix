// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payout_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PayoutRequest _$PayoutRequestFromJson(Map<String, dynamic> json) =>
    _PayoutRequest(
      createdAt: DateTime.parse(json['created_at'] as String),
      bank: json['bank'] as String,
      accNumber: json['acc_number'] as String,
      accName: json['acc_name'] as String,
      branchCode: json['branch_code'] as String,
      approvedAt: json['approved_at'] == null
          ? null
          : DateTime.parse(json['approved_at'] as String),
      id: (json['id'] as num).toInt(),
      accHolder: json['acc_holder'] as String,
      amount: (json['amount'] as num).toDouble(),
      walletId: (json['wallet_id'] as num).toInt(),
      transactionId: (json['transaction_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PayoutRequestToJson(_PayoutRequest instance) =>
    <String, dynamic>{
      'bank': instance.bank,
      'acc_number': instance.accNumber,
      'acc_name': instance.accName,
      'branch_code': instance.branchCode,
      'acc_holder': instance.accHolder,
      'amount': instance.amount,
      'wallet_id': instance.walletId,
    };
