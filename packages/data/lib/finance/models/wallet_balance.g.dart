// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WalletBalance _$WalletBalanceFromJson(Map<String, dynamic> json) =>
    _WalletBalance(
      walletId: (json['walletId'] as num).toInt(),
      walletType: json['walletType'] as String,
      availableBalance: (json['availableBalance'] as num?)?.toDouble(),
      totalBalance: (json['totalBalance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WalletBalanceToJson(_WalletBalance instance) =>
    <String, dynamic>{
      'walletId': instance.walletId,
      'walletType': instance.walletType,
      'availableBalance': instance.availableBalance,
      'totalBalance': instance.totalBalance,
    };
