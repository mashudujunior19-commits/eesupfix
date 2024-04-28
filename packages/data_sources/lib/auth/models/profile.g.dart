// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      userId: json['user_id'] as String,
      rsaIdNumber: json['rsa_id_number'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      isActive: json['is_active'] as bool?,
      deactivatedOn: json['deactivated_on'] == null
          ? null
          : DateTime.parse(json['deactivated_on'] as String),
      acceptedTsAndCs: json['accepted_ts_and_cs'] as bool?,
      role: const UserRoleConverter().fromJson(json['role'] as String),
      corpName: json['corp_name'] as String?,
      npcReg: json['npc_reg'] as String?,
      corpReg: json['corp_reg'] as String?,
      corpAddressId: (json['corp_address_id'] as num?)?.toInt(),
      corpVatNo: json['corp_vat_no'] as String?,
      isApproved: json['is_approved'] as bool?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      referralCode: (json['referral_code'] as num?)?.toInt(),
      isVerified: json['is_verified'] as bool,
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'rsa_id_number': instance.rsaIdNumber,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'is_active': instance.isActive,
      'deactivated_on': instance.deactivatedOn?.toIso8601String(),
      'accepted_ts_and_cs': instance.acceptedTsAndCs,
      'corp_name': instance.corpName,
      'npc_reg': instance.npcReg,
      'corp_reg': instance.corpReg,
      'corp_address_id': instance.corpAddressId,
      'corp_vat_no': instance.corpVatNo,
    };
