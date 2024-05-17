// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'voucher_ledger.freezed.dart';
part 'voucher_ledger.g.dart';

@freezed
class VoucherLedger with _$VoucherLedger {
  const factory VoucherLedger({
    @JsonKey(name: 'voucher_id') required int voucherId,
    @JsonKey(name: 'transaction_id') required int transactionId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'opening_balance') double? openingBalance,
    @JsonKey(name: 'payout') double? payout,
    @JsonKey(name: 'profit_share') double? profitShare,
    @JsonKey(name: 'closing_balance') required double closingBalance,
  }) = _VoucherLedger;

  factory VoucherLedger.fromJson(Map<String, dynamic> json) =>
      _$VoucherLedgerFromJson(json);
}
