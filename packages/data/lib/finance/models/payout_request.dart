// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'payout_request.freezed.dart';
part 'payout_request.g.dart';

@freezed
abstract class PayoutRequest with _$PayoutRequest {
  const factory PayoutRequest({
    @JsonKey(name: 'created_at', includeToJson: false)
    required DateTime createdAt,
    required String bank,
    @JsonKey(name: 'acc_number') required String accNumber,
    @JsonKey(name: 'acc_name') required String accName,
    @JsonKey(name: 'branch_code') required String branchCode,
    @JsonKey(name: 'approved_at', includeToJson: false) DateTime? approvedAt,
    @JsonKey(includeToJson: false) required int id,
    @JsonKey(name: 'acc_holder') required String accHolder,
    required double amount,
    @JsonKey(name: 'wallet_id') required int walletId,
    @JsonKey(name: 'transaction_id',includeToJson: false)  int? transactionId,
  }) = _PayoutRequest;

  factory PayoutRequest.fromJson(Map<String, dynamic> json) =>
      _$PayoutRequestFromJson(json);
}
