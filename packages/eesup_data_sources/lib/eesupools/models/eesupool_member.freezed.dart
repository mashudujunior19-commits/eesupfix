// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eesupool_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EESUpoolMember _$EESUpoolMemberFromJson(Map<String, dynamic> json) {
  return _EESUpoolMember.fromJson(json);
}

/// @nodoc
mixin _$EESUpoolMember {
  @JsonKey(name: "member_id", includeToJson: false)
  String get memberId => throw _privateConstructorUsedError;
  @JsonKey(name: "eesupool_id")
  int get eesupoolId => throw _privateConstructorUsedError;
  @JsonKey(name: "user_id")
  String get userId => throw _privateConstructorUsedError;
  @EESUpoolMemberRoleConverter()
  @JsonKey(name: "role")
  EESUpoolMemberRole get role => throw _privateConstructorUsedError;
  @JsonKey(name: "is_censored")
  bool get isCensored => throw _privateConstructorUsedError;
  @JsonKey(name: "full_name", includeToJson: false)
  String get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at", includeToJson: false)
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EESUpoolMemberCopyWith<EESUpoolMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EESUpoolMemberCopyWith<$Res> {
  factory $EESUpoolMemberCopyWith(
          EESUpoolMember value, $Res Function(EESUpoolMember) then) =
      _$EESUpoolMemberCopyWithImpl<$Res, EESUpoolMember>;
  @useResult
  $Res call(
      {@JsonKey(name: "member_id", includeToJson: false) String memberId,
      @JsonKey(name: "eesupool_id") int eesupoolId,
      @JsonKey(name: "user_id") String userId,
      @EESUpoolMemberRoleConverter()
      @JsonKey(name: "role")
      EESUpoolMemberRole role,
      @JsonKey(name: "is_censored") bool isCensored,
      @JsonKey(name: "full_name", includeToJson: false) String fullName,
      @JsonKey(name: "created_at", includeToJson: false) DateTime createdAt});
}

/// @nodoc
class _$EESUpoolMemberCopyWithImpl<$Res, $Val extends EESUpoolMember>
    implements $EESUpoolMemberCopyWith<$Res> {
  _$EESUpoolMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? eesupoolId = null,
    Object? userId = null,
    Object? role = null,
    Object? isCensored = null,
    Object? fullName = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      eesupoolId: null == eesupoolId
          ? _value.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as EESUpoolMemberRole,
      isCensored: null == isCensored
          ? _value.isCensored
          : isCensored // ignore: cast_nullable_to_non_nullable
              as bool,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EESUpoolMemberImplCopyWith<$Res>
    implements $EESUpoolMemberCopyWith<$Res> {
  factory _$$EESUpoolMemberImplCopyWith(_$EESUpoolMemberImpl value,
          $Res Function(_$EESUpoolMemberImpl) then) =
      __$$EESUpoolMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "member_id", includeToJson: false) String memberId,
      @JsonKey(name: "eesupool_id") int eesupoolId,
      @JsonKey(name: "user_id") String userId,
      @EESUpoolMemberRoleConverter()
      @JsonKey(name: "role")
      EESUpoolMemberRole role,
      @JsonKey(name: "is_censored") bool isCensored,
      @JsonKey(name: "full_name", includeToJson: false) String fullName,
      @JsonKey(name: "created_at", includeToJson: false) DateTime createdAt});
}

/// @nodoc
class __$$EESUpoolMemberImplCopyWithImpl<$Res>
    extends _$EESUpoolMemberCopyWithImpl<$Res, _$EESUpoolMemberImpl>
    implements _$$EESUpoolMemberImplCopyWith<$Res> {
  __$$EESUpoolMemberImplCopyWithImpl(
      _$EESUpoolMemberImpl _value, $Res Function(_$EESUpoolMemberImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? eesupoolId = null,
    Object? userId = null,
    Object? role = null,
    Object? isCensored = null,
    Object? fullName = null,
    Object? createdAt = null,
  }) {
    return _then(_$EESUpoolMemberImpl(
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      eesupoolId: null == eesupoolId
          ? _value.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as EESUpoolMemberRole,
      isCensored: null == isCensored
          ? _value.isCensored
          : isCensored // ignore: cast_nullable_to_non_nullable
              as bool,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EESUpoolMemberImpl implements _EESUpoolMember {
  const _$EESUpoolMemberImpl(
      {@JsonKey(name: "member_id", includeToJson: false) required this.memberId,
      @JsonKey(name: "eesupool_id") required this.eesupoolId,
      @JsonKey(name: "user_id") required this.userId,
      @EESUpoolMemberRoleConverter() @JsonKey(name: "role") required this.role,
      @JsonKey(name: "is_censored") required this.isCensored,
      @JsonKey(name: "full_name", includeToJson: false) required this.fullName,
      @JsonKey(name: "created_at", includeToJson: false)
      required this.createdAt});

  factory _$EESUpoolMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$EESUpoolMemberImplFromJson(json);

  @override
  @JsonKey(name: "member_id", includeToJson: false)
  final String memberId;
  @override
  @JsonKey(name: "eesupool_id")
  final int eesupoolId;
  @override
  @JsonKey(name: "user_id")
  final String userId;
  @override
  @EESUpoolMemberRoleConverter()
  @JsonKey(name: "role")
  final EESUpoolMemberRole role;
  @override
  @JsonKey(name: "is_censored")
  final bool isCensored;
  @override
  @JsonKey(name: "full_name", includeToJson: false)
  final String fullName;
  @override
  @JsonKey(name: "created_at", includeToJson: false)
  final DateTime createdAt;

  @override
  String toString() {
    return 'EESUpoolMember(memberId: $memberId, eesupoolId: $eesupoolId, userId: $userId, role: $role, isCensored: $isCensored, fullName: $fullName, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EESUpoolMemberImpl &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.eesupoolId, eesupoolId) ||
                other.eesupoolId == eesupoolId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.isCensored, isCensored) ||
                other.isCensored == isCensored) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, memberId, eesupoolId, userId,
      role, isCensored, fullName, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EESUpoolMemberImplCopyWith<_$EESUpoolMemberImpl> get copyWith =>
      __$$EESUpoolMemberImplCopyWithImpl<_$EESUpoolMemberImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EESUpoolMemberImplToJson(
      this,
    );
  }
}

abstract class _EESUpoolMember implements EESUpoolMember {
  const factory _EESUpoolMember(
      {@JsonKey(name: "member_id", includeToJson: false)
      required final String memberId,
      @JsonKey(name: "eesupool_id") required final int eesupoolId,
      @JsonKey(name: "user_id") required final String userId,
      @EESUpoolMemberRoleConverter()
      @JsonKey(name: "role")
      required final EESUpoolMemberRole role,
      @JsonKey(name: "is_censored") required final bool isCensored,
      @JsonKey(name: "full_name", includeToJson: false)
      required final String fullName,
      @JsonKey(name: "created_at", includeToJson: false)
      required final DateTime createdAt}) = _$EESUpoolMemberImpl;

  factory _EESUpoolMember.fromJson(Map<String, dynamic> json) =
      _$EESUpoolMemberImpl.fromJson;

  @override
  @JsonKey(name: "member_id", includeToJson: false)
  String get memberId;
  @override
  @JsonKey(name: "eesupool_id")
  int get eesupoolId;
  @override
  @JsonKey(name: "user_id")
  String get userId;
  @override
  @EESUpoolMemberRoleConverter()
  @JsonKey(name: "role")
  EESUpoolMemberRole get role;
  @override
  @JsonKey(name: "is_censored")
  bool get isCensored;
  @override
  @JsonKey(name: "full_name", includeToJson: false)
  String get fullName;
  @override
  @JsonKey(name: "created_at", includeToJson: false)
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$EESUpoolMemberImplCopyWith<_$EESUpoolMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
