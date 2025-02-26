// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletBalanceImpl _$$WalletBalanceImplFromJson(Map<String, dynamic> json) =>
    _$WalletBalanceImpl(
      walletId: (json['walletId'] as num).toInt(),
      walletType: json['walletType'] as String,
      availableBalance: (json['availableBalance'] as num).toDouble(),
      totalBalance: (json['totalBalance'] as num).toDouble(),
    );

Map<String, dynamic> _$$WalletBalanceImplToJson(_$WalletBalanceImpl instance) =>
    <String, dynamic>{
      'walletId': instance.walletId,
      'walletType': instance.walletType,
      'availableBalance': instance.availableBalance,
      'totalBalance': instance.totalBalance,
    };
