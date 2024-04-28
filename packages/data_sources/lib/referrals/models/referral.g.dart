// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referral.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReferralImpl _$$ReferralImplFromJson(Map<String, dynamic> json) =>
    _$ReferralImpl(
      referrerUserId: json['referrer_user_id'] as String,
      refereedUserId: json['refereed_user_id'] as String,
      refereedFullName: json['refereed_full_name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      transactionId: (json['transaction_id'] as num).toInt(),
      isCompleted: json['is_completed'] as bool,
    );

Map<String, dynamic> _$$ReferralImplToJson(_$ReferralImpl instance) =>
    <String, dynamic>{
      'referrer_user_id': instance.referrerUserId,
      'refereed_user_id': instance.refereedUserId,
      'refereed_full_name': instance.refereedFullName,
      'created_at': instance.createdAt.toIso8601String(),
      'transaction_id': instance.transactionId,
      'is_completed': instance.isCompleted,
    };
