// ignore_for_file: invalid_annotation_target

import 'package:data/auth/models/user_role.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'eesupool_request.freezed.dart';
part 'eesupool_request.g.dart';

@freezed
class EESUpoolRequest with _$EESUpoolRequest {
  factory EESUpoolRequest({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'eesupool_id') required int eesupoolId,
    @JsonKey(name: 'request_type') required String type,
    @JsonKey(name: 'status') required String status,
    @JsonKey(name: 'eesupool_name') String? eesupoolName,
    @JsonKey(name: 'full_name') String? fullName,
    @JsonKey(name: 'corporate_name') String? corporateName,
    @UserRoleConverter() required UserRole role,
  }) = _EESUpoolRequest;

  factory EESUpoolRequest.fromJson(Map<String, dynamic> json) =>
      _$EESUpoolRequestFromJson(json);
}
