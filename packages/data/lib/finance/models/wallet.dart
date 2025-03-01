// ignore_for_file: invalid_annotation_target

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet.freezed.dart';
part 'wallet.g.dart';

@freezed
abstract class Wallet with _$Wallet {
  factory Wallet({
    required int id,
    @JsonKey(name: 'user_id') required String userId,
    required double balance,
    @JsonKey(name: 'type_id') required String typeId,
    required String description,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'type_created_at') required DateTime typeCreatedAt,
    @JsonKey(name: 'withdrawals') required bool withdrawals,
    @JsonKey(name: 'deposits') required bool deposits,
    @JsonKey(name: 'transfers') required bool transfers,
    @JsonKey(name: 'shopping') required bool shopping,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'require_rsa_id') required bool requireRsaId,
    @JsonKey(name: 'sort_num') required int sortNumber,
  }) = _Wallet;

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
}
