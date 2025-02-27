import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_balance.freezed.dart';
part 'wallet_balance.g.dart';

@freezed
class WalletBalance with _$WalletBalance {
  const factory WalletBalance({
    required int walletId,
    required String walletType,
    required double? availableBalance,
    required double? totalBalance,
  }) = _WalletBalance;

  factory WalletBalance.fromJson(Map<String, dynamic> json) {
    return _$WalletBalanceFromJson({
      'walletId': json['wallet_id'] as int,
      'walletType': json['wallet_type'] as String,
      'availableBalance':
          (json['available_balance'] as num?)?.toDouble() ?? 0.0,
      'totalBalance': (json['total_balance'] as num?)?.toDouble() ?? 0.0,
    });
  }
}
