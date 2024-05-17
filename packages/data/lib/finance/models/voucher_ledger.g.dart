// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_ledger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoucherLedgerImpl _$$VoucherLedgerImplFromJson(Map<String, dynamic> json) =>
    _$VoucherLedgerImpl(
      voucherId: (json['voucher_id'] as num).toInt(),
      transactionId: (json['transaction_id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      openingBalance: (json['opening_balance'] as num?)?.toDouble(),
      payout: (json['payout'] as num?)?.toDouble(),
      profitShare: (json['profit_share'] as num?)?.toDouble(),
      closingBalance: (json['closing_balance'] as num).toDouble(),
    );

Map<String, dynamic> _$$VoucherLedgerImplToJson(_$VoucherLedgerImpl instance) =>
    <String, dynamic>{
      'voucher_id': instance.voucherId,
      'transaction_id': instance.transactionId,
      'created_at': instance.createdAt.toIso8601String(),
      'opening_balance': instance.openingBalance,
      'payout': instance.payout,
      'profit_share': instance.profitShare,
      'closing_balance': instance.closingBalance,
    };
