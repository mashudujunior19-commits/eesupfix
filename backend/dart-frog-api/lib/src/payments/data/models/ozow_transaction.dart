// ignore_for_file: invalid_annotation_target
import 'package:eesup_dart_frog/src/payments/data/models/ozow_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'ozow_transaction.freezed.dart';
part 'ozow_transaction.g.dart';

@freezed
class OzowTransaction with _$OzowTransaction {
  const factory OzowTransaction({
    String? transactionId,
    String? merchantCode,
    String? siteCode,
    String? transactionReference,
    String? currencyCode,
    String? statusMessage,
    String? subStatus,
    DateTime? createdDate,
    DateTime? paymentDate,
    String? bankName,
    String? maskedAccountNumber,
    String? smartIndicators,
    String? toBankName,
    String? toAccountNumber,
    @OzowStatusConverter() OzowStatus? status,
    double? amount,
  }) = _OzowTransaction;

  factory OzowTransaction.fromJson(Map<String, dynamic> json) =>
      _$OzowTransactionFromJson(json);
}
