import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_balance.freezed.dart';
part 'wallet_balance.g.dart';

@freezed
abstract class WalletBalance with _$WalletBalance {
  const factory WalletBalance({
    required int walletId,
    required String walletType,
    required double? availableBalance,
    required double? totalBalance,
  }) = _WalletBalance;

  factory WalletBalance.fromJson(Map<String, dynamic> json) =>
      _$WalletBalanceFromJson(json);
}

class WalletBalanceConverter
    implements JsonConverter<WalletBalance, Map<String, dynamic>> {
  const WalletBalanceConverter();

  @override
  WalletBalance fromJson(Map<String, dynamic> json) {
    return WalletBalance.fromJson({
      'walletId': json['wallet_id'] as int,
      'walletType': json['wallet_type'] as String,
      'availableBalance':
          (json['available_balance'] as num?)?.toDouble() ?? 0.0,
      'totalBalance': (json['total_balance'] as num?)?.toDouble() ?? 0.0,
    });
  }

  @override
  Map<String, dynamic> toJson(WalletBalance object) {
    return object.toJson();
  }
}
