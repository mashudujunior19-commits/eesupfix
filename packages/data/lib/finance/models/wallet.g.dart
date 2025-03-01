// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Wallet _$WalletFromJson(Map<String, dynamic> json) => _Wallet(
      id: (json['id'] as num).toInt(),
      userId: json['user_id'] as String,
      balance: (json['balance'] as num).toDouble(),
      typeId: json['type_id'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      typeCreatedAt: DateTime.parse(json['type_created_at'] as String),
      withdrawals: json['withdrawals'] as bool,
      deposits: json['deposits'] as bool,
      transfers: json['transfers'] as bool,
      shopping: json['shopping'] as bool,
      isActive: json['is_active'] as bool,
      requireRsaId: json['require_rsa_id'] as bool,
      sortNumber: (json['sort_num'] as num).toInt(),
    );

Map<String, dynamic> _$WalletToJson(_Wallet instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'balance': instance.balance,
      'type_id': instance.typeId,
      'description': instance.description,
      'created_at': instance.createdAt.toIso8601String(),
      'type_created_at': instance.typeCreatedAt.toIso8601String(),
      'withdrawals': instance.withdrawals,
      'deposits': instance.deposits,
      'transfers': instance.transfers,
      'shopping': instance.shopping,
      'is_active': instance.isActive,
      'require_rsa_id': instance.requireRsaId,
      'sort_num': instance.sortNumber,
    };
