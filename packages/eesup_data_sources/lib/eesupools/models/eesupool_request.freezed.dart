// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eesupool_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EESUpoolRequest _$EESUpoolRequestFromJson(Map<String, dynamic> json) {
  return _EESUpoolRequest.fromJson(json);
}

/// @nodoc
mixin _$EESUpoolRequest {
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'eesupool_id')
  int get eesupoolId => throw _privateConstructorUsedError;
  @JsonKey(name: 'request_type')
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'eesupool_name')
  String? get eesupoolName => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String? get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'corporate_name')
  String? get corporateName => throw _privateConstructorUsedError;
  @UserRoleConverter()
  UserRole get role => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EESUpoolRequestCopyWith<EESUpoolRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EESUpoolRequestCopyWith<$Res> {
  factory $EESUpoolRequestCopyWith(
          EESUpoolRequest value, $Res Function(EESUpoolRequest) then) =
      _$EESUpoolRequestCopyWithImpl<$Res, EESUpoolRequest>;
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
class _$EESUpoolRequestCopyWithImpl<$Res, $Val extends EESUpoolRequest>
    implements $EESUpoolRequestCopyWith<$Res> {
  _$EESUpoolRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      eesupoolId: null == eesupoolId
          ? _value.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      eesupoolName: freezed == eesupoolName
          ? _value.eesupoolName
          : eesupoolName // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      corporateName: freezed == corporateName
          ? _value.corporateName
          : corporateName // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EESUpoolRequestImplCopyWith<$Res>
    implements $EESUpoolRequestCopyWith<$Res> {
  factory _$$EESUpoolRequestImplCopyWith(_$EESUpoolRequestImpl value,
          $Res Function(_$EESUpoolRequestImpl) then) =
      __$$EESUpoolRequestImplCopyWithImpl<$Res>;
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
class __$$EESUpoolRequestImplCopyWithImpl<$Res>
    extends _$EESUpoolRequestCopyWithImpl<$Res, _$EESUpoolRequestImpl>
    implements _$$EESUpoolRequestImplCopyWith<$Res> {
  __$$EESUpoolRequestImplCopyWithImpl(
      _$EESUpoolRequestImpl _value, $Res Function(_$EESUpoolRequestImpl) _then)
      : super(_value, _then);

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
    return _then(_$EESUpoolRequestImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      eesupoolId: null == eesupoolId
          ? _value.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      eesupoolName: freezed == eesupoolName
          ? _value.eesupoolName
          : eesupoolName // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      corporateName: freezed == corporateName
          ? _value.corporateName
          : corporateName // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EESUpoolRequestImpl implements _EESUpoolRequest {
  _$EESUpoolRequestImpl(
      {@JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'eesupool_id') required this.eesupoolId,
      @JsonKey(name: 'request_type') required this.type,
      @JsonKey(name: 'status') required this.status,
      @JsonKey(name: 'eesupool_name') this.eesupoolName,
      @JsonKey(name: 'full_name') this.fullName,
      @JsonKey(name: 'corporate_name') this.corporateName,
      @UserRoleConverter() required this.role});

  factory _$EESUpoolRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$EESUpoolRequestImplFromJson(json);

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

  @override
  String toString() {
    return 'EESUpoolRequest(userId: $userId, createdAt: $createdAt, eesupoolId: $eesupoolId, type: $type, status: $status, eesupoolName: $eesupoolName, fullName: $fullName, corporateName: $corporateName, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EESUpoolRequestImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, createdAt, eesupoolId,
      type, status, eesupoolName, fullName, corporateName, role);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EESUpoolRequestImplCopyWith<_$EESUpoolRequestImpl> get copyWith =>
      __$$EESUpoolRequestImplCopyWithImpl<_$EESUpoolRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EESUpoolRequestImplToJson(
      this,
    );
  }
}

abstract class _EESUpoolRequest implements EESUpoolRequest {
  factory _EESUpoolRequest(
          {@JsonKey(name: 'user_id') required final String userId,
          @JsonKey(name: 'created_at') required final DateTime createdAt,
          @JsonKey(name: 'eesupool_id') required final int eesupoolId,
          @JsonKey(name: 'request_type') required final String type,
          @JsonKey(name: 'status') required final String status,
          @JsonKey(name: 'eesupool_name') final String? eesupoolName,
          @JsonKey(name: 'full_name') final String? fullName,
          @JsonKey(name: 'corporate_name') final String? corporateName,
          @UserRoleConverter() required final UserRole role}) =
      _$EESUpoolRequestImpl;

  factory _EESUpoolRequest.fromJson(Map<String, dynamic> json) =
      _$EESUpoolRequestImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'eesupool_id')
  int get eesupoolId;
  @override
  @JsonKey(name: 'request_type')
  String get type;
  @override
  @JsonKey(name: 'status')
  String get status;
  @override
  @JsonKey(name: 'eesupool_name')
  String? get eesupoolName;
  @override
  @JsonKey(name: 'full_name')
  String? get fullName;
  @override
  @JsonKey(name: 'corporate_name')
  String? get corporateName;
  @override
  @UserRoleConverter()
  UserRole get role;
  @override
  @JsonKey(ignore: true)
  _$$EESUpoolRequestImplCopyWith<_$EESUpoolRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
