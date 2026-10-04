// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eesupool_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EESUpoolMember {
  @JsonKey(name: "member_id", includeToJson: false)
  String get memberId;
  @JsonKey(name: "eesupool_id")
  int get eesupoolId;
  @JsonKey(name: "user_id")
  String get userId;
  @EESUpoolMemberRoleConverter()
  @JsonKey(name: "role")
  EESUpoolMemberRole get role;
  @JsonKey(name: "is_censored")
  bool get isCensored;
  @JsonKey(name: "full_name", includeToJson: false)
  String get fullName;
  @JsonKey(name: "created_at", includeToJson: false)
  DateTime get createdAt;

  /// Whether the member's profile is verified. Null when the source RPC
  /// doesn't report it; the database enforces the rule either way.
  @JsonKey(name: "is_verified", includeToJson: false)
  bool? get isVerified;

  /// Create a copy of EESUpoolMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EESUpoolMemberCopyWith<EESUpoolMember> get copyWith =>
      _$EESUpoolMemberCopyWithImpl<EESUpoolMember>(
          this as EESUpoolMember, _$identity);

  /// Serializes this EESUpoolMember to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EESUpoolMember &&
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
                other.createdAt == createdAt) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, memberId, eesupoolId, userId,
      role, isCensored, fullName, createdAt, isVerified);

  @override
  String toString() {
    return 'EESUpoolMember(memberId: $memberId, eesupoolId: $eesupoolId, userId: $userId, role: $role, isCensored: $isCensored, fullName: $fullName, createdAt: $createdAt, isVerified: $isVerified)';
  }
}

/// @nodoc
abstract mixin class $EESUpoolMemberCopyWith<$Res> {
  factory $EESUpoolMemberCopyWith(
          EESUpoolMember value, $Res Function(EESUpoolMember) _then) =
      _$EESUpoolMemberCopyWithImpl;
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
      @JsonKey(name: "created_at", includeToJson: false) DateTime createdAt,
      @JsonKey(name: "is_verified", includeToJson: false) bool? isVerified});
}

/// @nodoc
class _$EESUpoolMemberCopyWithImpl<$Res>
    implements $EESUpoolMemberCopyWith<$Res> {
  _$EESUpoolMemberCopyWithImpl(this._self, this._then);

  final EESUpoolMember _self;
  final $Res Function(EESUpoolMember) _then;

  /// Create a copy of EESUpoolMember
  /// with the given fields replaced by the non-null parameter values.
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
    Object? isVerified = freezed,
  }) {
    return _then(_self.copyWith(
      memberId: null == memberId
          ? _self.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      eesupoolId: null == eesupoolId
          ? _self.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as EESUpoolMemberRole,
      isCensored: null == isCensored
          ? _self.isCensored
          : isCensored // ignore: cast_nullable_to_non_nullable
              as bool,
      fullName: null == fullName
          ? _self.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isVerified: freezed == isVerified
          ? _self.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// Adds pattern-matching-related methods to [EESUpoolMember].
extension EESUpoolMemberPatterns on EESUpoolMember {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_EESUpoolMember value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EESUpoolMember() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_EESUpoolMember value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EESUpoolMember():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_EESUpoolMember value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EESUpoolMember() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: "member_id", includeToJson: false) String memberId,
            @JsonKey(name: "eesupool_id") int eesupoolId,
            @JsonKey(name: "user_id") String userId,
            @EESUpoolMemberRoleConverter()
            @JsonKey(name: "role")
            EESUpoolMemberRole role,
            @JsonKey(name: "is_censored") bool isCensored,
            @JsonKey(name: "full_name", includeToJson: false) String fullName,
            @JsonKey(name: "created_at", includeToJson: false)
            DateTime createdAt,
            @JsonKey(name: "is_verified", includeToJson: false)
            bool? isVerified)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EESUpoolMember() when $default != null:
        return $default(
            _that.memberId,
            _that.eesupoolId,
            _that.userId,
            _that.role,
            _that.isCensored,
            _that.fullName,
            _that.createdAt,
            _that.isVerified);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: "member_id", includeToJson: false) String memberId,
            @JsonKey(name: "eesupool_id") int eesupoolId,
            @JsonKey(name: "user_id") String userId,
            @EESUpoolMemberRoleConverter()
            @JsonKey(name: "role")
            EESUpoolMemberRole role,
            @JsonKey(name: "is_censored") bool isCensored,
            @JsonKey(name: "full_name", includeToJson: false) String fullName,
            @JsonKey(name: "created_at", includeToJson: false)
            DateTime createdAt,
            @JsonKey(name: "is_verified", includeToJson: false)
            bool? isVerified)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EESUpoolMember():
        return $default(
            _that.memberId,
            _that.eesupoolId,
            _that.userId,
            _that.role,
            _that.isCensored,
            _that.fullName,
            _that.createdAt,
            _that.isVerified);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @JsonKey(name: "member_id", includeToJson: false) String memberId,
            @JsonKey(name: "eesupool_id") int eesupoolId,
            @JsonKey(name: "user_id") String userId,
            @EESUpoolMemberRoleConverter()
            @JsonKey(name: "role")
            EESUpoolMemberRole role,
            @JsonKey(name: "is_censored") bool isCensored,
            @JsonKey(name: "full_name", includeToJson: false) String fullName,
            @JsonKey(name: "created_at", includeToJson: false)
            DateTime createdAt,
            @JsonKey(name: "is_verified", includeToJson: false)
            bool? isVerified)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EESUpoolMember() when $default != null:
        return $default(
            _that.memberId,
            _that.eesupoolId,
            _that.userId,
            _that.role,
            _that.isCensored,
            _that.fullName,
            _that.createdAt,
            _that.isVerified);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EESUpoolMember implements EESUpoolMember {
  const _EESUpoolMember(
      {@JsonKey(name: "member_id", includeToJson: false) required this.memberId,
      @JsonKey(name: "eesupool_id") required this.eesupoolId,
      @JsonKey(name: "user_id") required this.userId,
      @EESUpoolMemberRoleConverter() @JsonKey(name: "role") required this.role,
      @JsonKey(name: "is_censored") required this.isCensored,
      @JsonKey(name: "full_name", includeToJson: false) required this.fullName,
      @JsonKey(name: "created_at", includeToJson: false)
      required this.createdAt,
      @JsonKey(name: "is_verified", includeToJson: false) this.isVerified});
  factory _EESUpoolMember.fromJson(Map<String, dynamic> json) =>
      _$EESUpoolMemberFromJson(json);

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

  /// Whether the member's profile is verified. Null when the source RPC
  /// doesn't report it; the database enforces the rule either way.
  @override
  @JsonKey(name: "is_verified", includeToJson: false)
  final bool? isVerified;

  /// Create a copy of EESUpoolMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EESUpoolMemberCopyWith<_EESUpoolMember> get copyWith =>
      __$EESUpoolMemberCopyWithImpl<_EESUpoolMember>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EESUpoolMemberToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EESUpoolMember &&
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
                other.createdAt == createdAt) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, memberId, eesupoolId, userId,
      role, isCensored, fullName, createdAt, isVerified);

  @override
  String toString() {
    return 'EESUpoolMember(memberId: $memberId, eesupoolId: $eesupoolId, userId: $userId, role: $role, isCensored: $isCensored, fullName: $fullName, createdAt: $createdAt, isVerified: $isVerified)';
  }
}

/// @nodoc
abstract mixin class _$EESUpoolMemberCopyWith<$Res>
    implements $EESUpoolMemberCopyWith<$Res> {
  factory _$EESUpoolMemberCopyWith(
          _EESUpoolMember value, $Res Function(_EESUpoolMember) _then) =
      __$EESUpoolMemberCopyWithImpl;
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
      @JsonKey(name: "created_at", includeToJson: false) DateTime createdAt,
      @JsonKey(name: "is_verified", includeToJson: false) bool? isVerified});
}

/// @nodoc
class __$EESUpoolMemberCopyWithImpl<$Res>
    implements _$EESUpoolMemberCopyWith<$Res> {
  __$EESUpoolMemberCopyWithImpl(this._self, this._then);

  final _EESUpoolMember _self;
  final $Res Function(_EESUpoolMember) _then;

  /// Create a copy of EESUpoolMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? memberId = null,
    Object? eesupoolId = null,
    Object? userId = null,
    Object? role = null,
    Object? isCensored = null,
    Object? fullName = null,
    Object? createdAt = null,
    Object? isVerified = freezed,
  }) {
    return _then(_EESUpoolMember(
      memberId: null == memberId
          ? _self.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      eesupoolId: null == eesupoolId
          ? _self.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as EESUpoolMemberRole,
      isCensored: null == isCensored
          ? _self.isCensored
          : isCensored // ignore: cast_nullable_to_non_nullable
              as bool,
      fullName: null == fullName
          ? _self.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isVerified: freezed == isVerified
          ? _self.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

// dart format on
