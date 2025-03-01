// ignore_for_file: invalid_annotation_target

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart'; // For JSON serialization

@freezed
abstract class Transaction with _$Transaction {
  const factory Transaction({
    required int id,
    required String type,
    @JsonKey(name: 'doc_ref') required int docRef,
    @JsonKey(name: 'value') required double value,
    @JsonKey(name: 'vested') required bool vested,
    @JsonKey(name: 'description') required String description,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'confirmed_at') DateTime? confirmedAt,
    @JsonKey(name: 'cancelled_at') DateTime? cancelledAt,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
