// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'eesupool_member.freezed.dart';
part 'eesupool_member.g.dart';

@freezed
abstract class EESUpoolMember with _$EESUpoolMember {
  const factory EESUpoolMember({
    @JsonKey(name: "member_id", includeToJson: false) required String memberId,
    @JsonKey(name: "eesupool_id") required int eesupoolId,
    @JsonKey(name: "user_id") required String userId,
    @EESUpoolMemberRoleConverter()
    @JsonKey(name: "role")
    required EESUpoolMemberRole role,
    @JsonKey(name: "is_censored") required bool isCensored,
    @JsonKey(name: "full_name", includeToJson: false) required String fullName,
    @JsonKey(name: "created_at", includeToJson: false)
    required DateTime createdAt,
  }) = _EESUpoolMember;

  factory EESUpoolMember.fromJson(Map<String, dynamic> json) =>
      _$EESUpoolMemberFromJson(json);
}

class EESUpoolMemberConverter
    implements JsonConverter<EESUpoolMember, Map<String, dynamic>> {
  const EESUpoolMemberConverter();

  @override
  EESUpoolMember fromJson(Map<String, dynamic> json) {
    return EESUpoolMember.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(EESUpoolMember object) {
    return object.toJson();
  }
}

class EESUpoolMemberRoleConverter
    implements JsonConverter<EESUpoolMemberRole, String> {
  const EESUpoolMemberRoleConverter();

  @override
  EESUpoolMemberRole fromJson(String str) {
    return EESUpoolMemberRole.fromString(str);
  }

  @override
  String toJson(EESUpoolMemberRole object) {
    return object.toString();
  }
}

enum EESUpoolMemberRole {
  admin,
  member;

  factory EESUpoolMemberRole.fromString(String role) {
    switch (role) {
      case "Admin":
        return EESUpoolMemberRole.admin;
      case "Member":
        return EESUpoolMemberRole.member;
      default:
        throw Exception("Unknown role $role");
    }
  }

  @override
  String toString() {
    switch (this) {
      case EESUpoolMemberRole.admin:
        return "Admin";
      case EESUpoolMemberRole.member:
        return "Member";
    }
  }
}
