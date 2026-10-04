// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationData {
  @JsonKey(name: 'user_id')
  String? get userId;
  @JsonKey(name: 'eesupool_id')
  int? get eesupoolId;
  @JsonKey(name: 'order_id')
  int? get orderId;
  @JsonKey(name: 'eesupool_order_id')
  int? get eesupoolOrderId;

  /// Create a copy of NotificationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NotificationDataCopyWith<NotificationData> get copyWith =>
      _$NotificationDataCopyWithImpl<NotificationData>(
          this as NotificationData, _$identity);

  /// Serializes this NotificationData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NotificationData &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.eesupoolId, eesupoolId) ||
                other.eesupoolId == eesupoolId) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.eesupoolOrderId, eesupoolOrderId) ||
                other.eesupoolOrderId == eesupoolOrderId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, eesupoolId, orderId, eesupoolOrderId);

  @override
  String toString() {
    return 'NotificationData(userId: $userId, eesupoolId: $eesupoolId, orderId: $orderId, eesupoolOrderId: $eesupoolOrderId)';
  }
}

/// @nodoc
abstract mixin class $NotificationDataCopyWith<$Res> {
  factory $NotificationDataCopyWith(
          NotificationData value, $Res Function(NotificationData) _then) =
      _$NotificationDataCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'eesupool_id') int? eesupoolId,
      @JsonKey(name: 'order_id') int? orderId,
      @JsonKey(name: 'eesupool_order_id') int? eesupoolOrderId});
}

/// @nodoc
class _$NotificationDataCopyWithImpl<$Res>
    implements $NotificationDataCopyWith<$Res> {
  _$NotificationDataCopyWithImpl(this._self, this._then);

  final NotificationData _self;
  final $Res Function(NotificationData) _then;

  /// Create a copy of NotificationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? eesupoolId = freezed,
    Object? orderId = freezed,
    Object? eesupoolOrderId = freezed,
  }) {
    return _then(_self.copyWith(
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      eesupoolId: freezed == eesupoolId
          ? _self.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int?,
      orderId: freezed == orderId
          ? _self.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int?,
      eesupoolOrderId: freezed == eesupoolOrderId
          ? _self.eesupoolOrderId
          : eesupoolOrderId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [NotificationData].
extension NotificationDataPatterns on NotificationData {
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
    TResult Function(_NotificationData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationData() when $default != null:
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
    TResult Function(_NotificationData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationData():
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
    TResult? Function(_NotificationData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationData() when $default != null:
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
            @JsonKey(name: 'user_id') String? userId,
            @JsonKey(name: 'eesupool_id') int? eesupoolId,
            @JsonKey(name: 'order_id') int? orderId,
            @JsonKey(name: 'eesupool_order_id') int? eesupoolOrderId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationData() when $default != null:
        return $default(_that.userId, _that.eesupoolId, _that.orderId,
            _that.eesupoolOrderId);
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
            @JsonKey(name: 'user_id') String? userId,
            @JsonKey(name: 'eesupool_id') int? eesupoolId,
            @JsonKey(name: 'order_id') int? orderId,
            @JsonKey(name: 'eesupool_order_id') int? eesupoolOrderId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationData():
        return $default(_that.userId, _that.eesupoolId, _that.orderId,
            _that.eesupoolOrderId);
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
            @JsonKey(name: 'user_id') String? userId,
            @JsonKey(name: 'eesupool_id') int? eesupoolId,
            @JsonKey(name: 'order_id') int? orderId,
            @JsonKey(name: 'eesupool_order_id') int? eesupoolOrderId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationData() when $default != null:
        return $default(_that.userId, _that.eesupoolId, _that.orderId,
            _that.eesupoolOrderId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _NotificationData implements NotificationData {
  const _NotificationData(
      {@JsonKey(name: 'user_id') this.userId,
      @JsonKey(name: 'eesupool_id') this.eesupoolId,
      @JsonKey(name: 'order_id') this.orderId,
      @JsonKey(name: 'eesupool_order_id') this.eesupoolOrderId});
  factory _NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  @JsonKey(name: 'eesupool_id')
  final int? eesupoolId;
  @override
  @JsonKey(name: 'order_id')
  final int? orderId;
  @override
  @JsonKey(name: 'eesupool_order_id')
  final int? eesupoolOrderId;

  /// Create a copy of NotificationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NotificationDataCopyWith<_NotificationData> get copyWith =>
      __$NotificationDataCopyWithImpl<_NotificationData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NotificationDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotificationData &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.eesupoolId, eesupoolId) ||
                other.eesupoolId == eesupoolId) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.eesupoolOrderId, eesupoolOrderId) ||
                other.eesupoolOrderId == eesupoolOrderId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, eesupoolId, orderId, eesupoolOrderId);

  @override
  String toString() {
    return 'NotificationData(userId: $userId, eesupoolId: $eesupoolId, orderId: $orderId, eesupoolOrderId: $eesupoolOrderId)';
  }
}

/// @nodoc
abstract mixin class _$NotificationDataCopyWith<$Res>
    implements $NotificationDataCopyWith<$Res> {
  factory _$NotificationDataCopyWith(
          _NotificationData value, $Res Function(_NotificationData) _then) =
      __$NotificationDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'eesupool_id') int? eesupoolId,
      @JsonKey(name: 'order_id') int? orderId,
      @JsonKey(name: 'eesupool_order_id') int? eesupoolOrderId});
}

/// @nodoc
class __$NotificationDataCopyWithImpl<$Res>
    implements _$NotificationDataCopyWith<$Res> {
  __$NotificationDataCopyWithImpl(this._self, this._then);

  final _NotificationData _self;
  final $Res Function(_NotificationData) _then;

  /// Create a copy of NotificationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = freezed,
    Object? eesupoolId = freezed,
    Object? orderId = freezed,
    Object? eesupoolOrderId = freezed,
  }) {
    return _then(_NotificationData(
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      eesupoolId: freezed == eesupoolId
          ? _self.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int?,
      orderId: freezed == orderId
          ? _self.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int?,
      eesupoolOrderId: freezed == eesupoolOrderId
          ? _self.eesupoolOrderId
          : eesupoolOrderId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
