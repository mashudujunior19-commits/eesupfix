import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_balance.freezed.dart';
part 'wallet_balance.g.dart';

@freezed
class WalletBalance with _$WalletBalance {
  const factory WalletBalance({
    required int walletId,
    required String walletType,
    required double availableBalance,
    required double totalBalance,
  }) = _WalletBalance;

  factory WalletBalance.fromJson(Map<String, dynamic> json) =>
      _$WalletBalanceFromJson(json);
}
