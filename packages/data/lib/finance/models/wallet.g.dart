// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletImpl _$$WalletImplFromJson(Map<String, dynamic> json) => _$WalletImpl(
      id: json['id'] as int,
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
      sortNumber: json['sort_num'] as int,
    );

Map<String, dynamic> _$$WalletImplToJson(_$WalletImpl instance) =>
    <String, dynamic>{
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
