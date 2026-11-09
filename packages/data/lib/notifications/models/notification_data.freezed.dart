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

  /// 'Accepted' / 'Declined' once an invite or join request was answered.
  @JsonKey(name: 'response')
  String? get response;

  /// 'get_involved' or 'partner_application' for application updates.
  @JsonKey(name: 'kind')
  String? get kind;

  /// submitted | approved | declined
  @JsonKey(name: 'event')
  String? get event;
  @JsonKey(name: 'submission_id')
  String? get submissionId;
  @JsonKey(name: 'application_id')
  int? get applicationId;
  @JsonKey(name: 'partner_id')
  String? get partnerId;
  @JsonKey(name: 'reason')
  String? get reason;

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
                other.eesupoolOrderId == eesupoolOrderId) &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.submissionId, submissionId) ||
                other.submissionId == submissionId) &&
            (identical(other.applicationId, applicationId) ||
                other.applicationId == applicationId) &&
            (identical(other.partnerId, partnerId) ||
                other.partnerId == partnerId) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      eesupoolId,
      orderId,
      eesupoolOrderId,
      response,
      kind,
      event,
      submissionId,
      applicationId,
      partnerId,
      reason);

  @override
  String toString() {
    return 'NotificationData(userId: $userId, eesupoolId: $eesupoolId, orderId: $orderId, eesupoolOrderId: $eesupoolOrderId, response: $response, kind: $kind, event: $event, submissionId: $submissionId, applicationId: $applicationId, partnerId: $partnerId, reason: $reason)';
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
      @JsonKey(name: 'eesupool_order_id') int? eesupoolOrderId,
      @JsonKey(name: 'response') String? response,
      @JsonKey(name: 'kind') String? kind,
      @JsonKey(name: 'event') String? event,
      @JsonKey(name: 'submission_id') String? submissionId,
      @JsonKey(name: 'application_id') int? applicationId,
      @JsonKey(name: 'partner_id') String? partnerId,
      @JsonKey(name: 'reason') String? reason});
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
    Object? response = freezed,
    Object? kind = freezed,
    Object? event = freezed,
    Object? submissionId = freezed,
    Object? applicationId = freezed,
    Object? partnerId = freezed,
    Object? reason = freezed,
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
      response: freezed == response
          ? _self.response
          : response // ignore: cast_nullable_to_non_nullable
              as String?,
      kind: freezed == kind
          ? _self.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String?,
      event: freezed == event
          ? _self.event
          : event // ignore: cast_nullable_to_non_nullable
              as String?,
      submissionId: freezed == submissionId
          ? _self.submissionId
          : submissionId // ignore: cast_nullable_to_non_nullable
              as String?,
      applicationId: freezed == applicationId
          ? _self.applicationId
          : applicationId // ignore: cast_nullable_to_non_nullable
              as int?,
      partnerId: freezed == partnerId
          ? _self.partnerId
          : partnerId // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: freezed == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
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
            @JsonKey(name: 'eesupool_order_id') int? eesupoolOrderId,
            @JsonKey(name: 'response') String? response,
            @JsonKey(name: 'kind') String? kind,
            @JsonKey(name: 'event') String? event,
            @JsonKey(name: 'submission_id') String? submissionId,
            @JsonKey(name: 'application_id') int? applicationId,
            @JsonKey(name: 'partner_id') String? partnerId,
            @JsonKey(name: 'reason') String? reason)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotificationData() when $default != null:
        return $default(
            _that.userId,
            _that.eesupoolId,
            _that.orderId,
            _that.eesupoolOrderId,
            _that.response,
            _that.kind,
            _that.event,
            _that.submissionId,
            _that.applicationId,
            _that.partnerId,
            _that.reason);
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
            @JsonKey(name: 'eesupool_order_id') int? eesupoolOrderId,
            @JsonKey(name: 'response') String? response,
            @JsonKey(name: 'kind') String? kind,
            @JsonKey(name: 'event') String? event,
            @JsonKey(name: 'submission_id') String? submissionId,
            @JsonKey(name: 'application_id') int? applicationId,
            @JsonKey(name: 'partner_id') String? partnerId,
            @JsonKey(name: 'reason') String? reason)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationData():
        return $default(
            _that.userId,
            _that.eesupoolId,
            _that.orderId,
            _that.eesupoolOrderId,
            _that.response,
            _that.kind,
            _that.event,
            _that.submissionId,
            _that.applicationId,
            _that.partnerId,
            _that.reason);
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
            @JsonKey(name: 'eesupool_order_id') int? eesupoolOrderId,
            @JsonKey(name: 'response') String? response,
            @JsonKey(name: 'kind') String? kind,
            @JsonKey(name: 'event') String? event,
            @JsonKey(name: 'submission_id') String? submissionId,
            @JsonKey(name: 'application_id') int? applicationId,
            @JsonKey(name: 'partner_id') String? partnerId,
            @JsonKey(name: 'reason') String? reason)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotificationData() when $default != null:
        return $default(
            _that.userId,
            _that.eesupoolId,
            _that.orderId,
            _that.eesupoolOrderId,
            _that.response,
            _that.kind,
            _that.event,
            _that.submissionId,
            _that.applicationId,
            _that.partnerId,
            _that.reason);
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
      @JsonKey(name: 'eesupool_order_id') this.eesupoolOrderId,
      @JsonKey(name: 'response') this.response,
      @JsonKey(name: 'kind') this.kind,
      @JsonKey(name: 'event') this.event,
      @JsonKey(name: 'submission_id') this.submissionId,
      @JsonKey(name: 'application_id') this.applicationId,
      @JsonKey(name: 'partner_id') this.partnerId,
      @JsonKey(name: 'reason') this.reason});
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

  /// 'Accepted' / 'Declined' once an invite or join request was answered.
  @override
  @JsonKey(name: 'response')
  final String? response;

  /// 'get_involved' or 'partner_application' for application updates.
  @override
  @JsonKey(name: 'kind')
  final String? kind;

  /// submitted | approved | declined
  @override
  @JsonKey(name: 'event')
  final String? event;
  @override
  @JsonKey(name: 'submission_id')
  final String? submissionId;
  @override
  @JsonKey(name: 'application_id')
  final int? applicationId;
  @override
  @JsonKey(name: 'partner_id')
  final String? partnerId;
  @override
  @JsonKey(name: 'reason')
  final String? reason;

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
                other.eesupoolOrderId == eesupoolOrderId) &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.submissionId, submissionId) ||
                other.submissionId == submissionId) &&
            (identical(other.applicationId, applicationId) ||
                other.applicationId == applicationId) &&
            (identical(other.partnerId, partnerId) ||
                other.partnerId == partnerId) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      eesupoolId,
      orderId,
      eesupoolOrderId,
      response,
      kind,
      event,
      submissionId,
      applicationId,
      partnerId,
      reason);

  @override
  String toString() {
    return 'NotificationData(userId: $userId, eesupoolId: $eesupoolId, orderId: $orderId, eesupoolOrderId: $eesupoolOrderId, response: $response, kind: $kind, event: $event, submissionId: $submissionId, applicationId: $applicationId, partnerId: $partnerId, reason: $reason)';
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
      @JsonKey(name: 'eesupool_order_id') int? eesupoolOrderId,
      @JsonKey(name: 'response') String? response,
      @JsonKey(name: 'kind') String? kind,
      @JsonKey(name: 'event') String? event,
      @JsonKey(name: 'submission_id') String? submissionId,
      @JsonKey(name: 'application_id') int? applicationId,
      @JsonKey(name: 'partner_id') String? partnerId,
      @JsonKey(name: 'reason') String? reason});
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
    Object? response = freezed,
    Object? kind = freezed,
    Object? event = freezed,
    Object? submissionId = freezed,
    Object? applicationId = freezed,
    Object? partnerId = freezed,
    Object? reason = freezed,
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
      response: freezed == response
          ? _self.response
          : response // ignore: cast_nullable_to_non_nullable
              as String?,
      kind: freezed == kind
          ? _self.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String?,
      event: freezed == event
          ? _self.event
          : event // ignore: cast_nullable_to_non_nullable
              as String?,
      submissionId: freezed == submissionId
          ? _self.submissionId
          : submissionId // ignore: cast_nullable_to_non_nullable
              as String?,
      applicationId: freezed == applicationId
          ? _self.applicationId
          : applicationId // ignore: cast_nullable_to_non_nullable
              as int?,
      partnerId: freezed == partnerId
          ? _self.partnerId
          : partnerId // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: freezed == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
