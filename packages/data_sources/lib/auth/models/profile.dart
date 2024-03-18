// ignore_for_file: invalid_annotation_target

import 'package:data_sources/auth/models/user_role.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

///Check box for
@freezed
class Profile with _$Profile {
  const factory Profile({
    @JsonKey(name: 'user_id', includeToJson: false) required String userId,
    @JsonKey(name: 'rsa_id_number') String? rsaIdNumber,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(includeToJson: false) String? email,
    @JsonKey(includeToJson: false) String? phone,
    @JsonKey(name: 'is_active') bool? isActive,
    @JsonKey(name: 'deactivated_on') DateTime? deactivatedOn,
    @JsonKey(name: 'accepted_ts_and_cs') bool? acceptedTsAndCs,
    @JsonKey(includeToJson: false) @UserRoleConverter() required UserRole role,
    @JsonKey(name: 'corp_name') String? corpName,
    @JsonKey(name: 'npc_reg') String? npcReg,
    @JsonKey(name: 'corp_reg') String? corpReg,
    @JsonKey(name: 'corp_address_id') int? corpAddressId,
    @JsonKey(name: 'corp_vat_no') String? corpVatNo,
    @JsonKey(name: 'is_approved', includeToJson: false) bool? isApproved,
    @JsonKey(name: 'created_at', includeToJson: false) DateTime? createdAt,
    @JsonKey(name: 'referral_code', includeToJson: false) int? referralCode,
    @JsonKey(name: 'is_verified', includeToJson: false)
    required bool isVerified,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}

class ProfileConverter implements JsonConverter<Profile, Map<String, dynamic>> {
  const ProfileConverter();

  @override
  Profile fromJson(Map<String, dynamic> json) {
    return Profile.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Profile object) {
    return object.toJson();
  }
}
