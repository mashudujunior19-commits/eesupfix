// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eesupool_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EESUpoolRequest {
  @JsonKey(name: 'user_id')
  String get userId;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @JsonKey(name: 'eesupool_id')
  int get eesupoolId;
  @JsonKey(name: 'request_type')
  String get type;
  @JsonKey(name: 'status')
  String get status;
  @JsonKey(name: 'eesupool_name')
  String? get eesupoolName;
  @JsonKey(name: 'full_name')
  String? get fullName;
  @JsonKey(name: 'corporate_name')
  String? get corporateName;
  @UserRoleConverter()
  UserRole get role;

  /// Create a copy of EESUpoolRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EESUpoolRequestCopyWith<EESUpoolRequest> get copyWith =>
      _$EESUpoolRequestCopyWithImpl<EESUpoolRequest>(
          this as EESUpoolRequest, _$identity);

  /// Serializes this EESUpoolRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EESUpoolRequest &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.eesupoolId, eesupoolId) ||
                other.eesupoolId == eesupoolId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.eesupoolName, eesupoolName) ||
                other.eesupoolName == eesupoolName) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.corporateName, corporateName) ||
                other.corporateName == corporateName) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, createdAt, eesupoolId,
      type, status, eesupoolName, fullName, corporateName, role);

  @override
  String toString() {
    return 'EESUpoolRequest(userId: $userId, createdAt: $createdAt, eesupoolId: $eesupoolId, type: $type, status: $status, eesupoolName: $eesupoolName, fullName: $fullName, corporateName: $corporateName, role: $role)';
  }
}

/// @nodoc
abstract mixin class $EESUpoolRequestCopyWith<$Res> {
  factory $EESUpoolRequestCopyWith(
          EESUpoolRequest value, $Res Function(EESUpoolRequest) _then) =
      _$EESUpoolRequestCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'eesupool_id') int eesupoolId,
      @JsonKey(name: 'request_type') String type,
      @JsonKey(name: 'status') String status,
      @JsonKey(name: 'eesupool_name') String? eesupoolName,
      @JsonKey(name: 'full_name') String? fullName,
      @JsonKey(name: 'corporate_name') String? corporateName,
      @UserRoleConverter() UserRole role});
}

/// @nodoc
class _$EESUpoolRequestCopyWithImpl<$Res>
    implements $EESUpoolRequestCopyWith<$Res> {
  _$EESUpoolRequestCopyWithImpl(this._self, this._then);

  final EESUpoolRequest _self;
  final $Res Function(EESUpoolRequest) _then;

  /// Create a copy of EESUpoolRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? createdAt = null,
    Object? eesupoolId = null,
    Object? type = null,
    Object? status = null,
    Object? eesupoolName = freezed,
    Object? fullName = freezed,
    Object? corporateName = freezed,
    Object? role = null,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      eesupoolId: null == eesupoolId
          ? _self.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      eesupoolName: freezed == eesupoolName
          ? _self.eesupoolName
          : eesupoolName // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: freezed == fullName
          ? _self.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      corporateName: freezed == corporateName
          ? _self.corporateName
          : corporateName // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _EESUpoolRequest implements EESUpoolRequest {
  _EESUpoolRequest(
      {@JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'eesupool_id') required this.eesupoolId,
      @JsonKey(name: 'request_type') required this.type,
      @JsonKey(name: 'status') required this.status,
      @JsonKey(name: 'eesupool_name') this.eesupoolName,
      @JsonKey(name: 'full_name') this.fullName,
      @JsonKey(name: 'corporate_name') this.corporateName,
      @UserRoleConverter() required this.role});
  factory _EESUpoolRequest.fromJson(Map<String, dynamic> json) =>
      _$EESUpoolRequestFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'eesupool_id')
  final int eesupoolId;
  @override
  @JsonKey(name: 'request_type')
  final String type;
  @override
  @JsonKey(name: 'status')
  final String status;
  @override
  @JsonKey(name: 'eesupool_name')
  final String? eesupoolName;
  @override
  @JsonKey(name: 'full_name')
  final String? fullName;
  @override
  @JsonKey(name: 'corporate_name')
  final String? corporateName;
  @override
  @UserRoleConverter()
  final UserRole role;

  /// Create a copy of EESUpoolRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EESUpoolRequestCopyWith<_EESUpoolRequest> get copyWith =>
      __$EESUpoolRequestCopyWithImpl<_EESUpoolRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EESUpoolRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EESUpoolRequest &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.eesupoolId, eesupoolId) ||
                other.eesupoolId == eesupoolId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.eesupoolName, eesupoolName) ||
                other.eesupoolName == eesupoolName) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.corporateName, corporateName) ||
                other.corporateName == corporateName) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, createdAt, eesupoolId,
      type, status, eesupoolName, fullName, corporateName, role);

  @override
  String toString() {
    return 'EESUpoolRequest(userId: $userId, createdAt: $createdAt, eesupoolId: $eesupoolId, type: $type, status: $status, eesupoolName: $eesupoolName, fullName: $fullName, corporateName: $corporateName, role: $role)';
  }
}

/// @nodoc
abstract mixin class _$EESUpoolRequestCopyWith<$Res>
    implements $EESUpoolRequestCopyWith<$Res> {
  factory _$EESUpoolRequestCopyWith(
          _EESUpoolRequest value, $Res Function(_EESUpoolRequest) _then) =
      __$EESUpoolRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'eesupool_id') int eesupoolId,
      @JsonKey(name: 'request_type') String type,
      @JsonKey(name: 'status') String status,
      @JsonKey(name: 'eesupool_name') String? eesupoolName,
      @JsonKey(name: 'full_name') String? fullName,
      @JsonKey(name: 'corporate_name') String? corporateName,
      @UserRoleConverter() UserRole role});
}

/// @nodoc
class __$EESUpoolRequestCopyWithImpl<$Res>
    implements _$EESUpoolRequestCopyWith<$Res> {
  __$EESUpoolRequestCopyWithImpl(this._self, this._then);

  final _EESUpoolRequest _self;
  final $Res Function(_EESUpoolRequest) _then;

  /// Create a copy of EESUpoolRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? createdAt = null,
    Object? eesupoolId = null,
    Object? type = null,
    Object? status = null,
    Object? eesupoolName = freezed,
    Object? fullName = freezed,
    Object? corporateName = freezed,
    Object? role = null,
  }) {
    return _then(_EESUpoolRequest(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      eesupoolId: null == eesupoolId
          ? _self.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      eesupoolName: freezed == eesupoolName
          ? _self.eesupoolName
          : eesupoolName // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: freezed == fullName
          ? _self.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      corporateName: freezed == corporateName
          ? _self.corporateName
          : corporateName // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
    ));
  }
}

// dart format on
