// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner_application.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PartnerApplication implements DiagnosticableTreeMixin {
  int get id;
  @JsonKey(name: 'partner_id')
  String get partnerId;
  @JsonKey(name: 'user_id')
  String get userId;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @JsonKey(name: 'approved_at')
  DateTime? get approvedAt;
  @JsonKey(name: 'rejected_at')
  DateTime? get rejectedAt;

  /// Why the reviewer declined it (shown to the applicant).
  @JsonKey(name: 'decline_reason')
  String? get declineReason;
  @PartnerSurveyResponseConverter()
  @JsonKey(name: 'survey_responses')
  List<PartnerSurveyResponse> get surveyResponses;

  /// Create a copy of PartnerApplication
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PartnerApplicationCopyWith<PartnerApplication> get copyWith =>
      _$PartnerApplicationCopyWithImpl<PartnerApplication>(
          this as PartnerApplication, _$identity);

  /// Serializes this PartnerApplication to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'PartnerApplication'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('partnerId', partnerId))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('approvedAt', approvedAt))
      ..add(DiagnosticsProperty('rejectedAt', rejectedAt))
      ..add(DiagnosticsProperty('declineReason', declineReason))
      ..add(DiagnosticsProperty('surveyResponses', surveyResponses));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PartnerApplication &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.partnerId, partnerId) ||
                other.partnerId == partnerId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.rejectedAt, rejectedAt) ||
                other.rejectedAt == rejectedAt) &&
            (identical(other.declineReason, declineReason) ||
                other.declineReason == declineReason) &&
            const DeepCollectionEquality()
                .equals(other.surveyResponses, surveyResponses));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      partnerId,
      userId,
      createdAt,
      approvedAt,
      rejectedAt,
      declineReason,
      const DeepCollectionEquality().hash(surveyResponses));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PartnerApplication(id: $id, partnerId: $partnerId, userId: $userId, createdAt: $createdAt, approvedAt: $approvedAt, rejectedAt: $rejectedAt, declineReason: $declineReason, surveyResponses: $surveyResponses)';
  }
}

/// @nodoc
abstract mixin class $PartnerApplicationCopyWith<$Res> {
  factory $PartnerApplicationCopyWith(
          PartnerApplication value, $Res Function(PartnerApplication) _then) =
      _$PartnerApplicationCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'partner_id') String partnerId,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'approved_at') DateTime? approvedAt,
      @JsonKey(name: 'rejected_at') DateTime? rejectedAt,
      @JsonKey(name: 'decline_reason') String? declineReason,
      @PartnerSurveyResponseConverter()
      @JsonKey(name: 'survey_responses')
      List<PartnerSurveyResponse> surveyResponses});
}

/// @nodoc
class _$PartnerApplicationCopyWithImpl<$Res>
    implements $PartnerApplicationCopyWith<$Res> {
  _$PartnerApplicationCopyWithImpl(this._self, this._then);

  final PartnerApplication _self;
  final $Res Function(PartnerApplication) _then;

  /// Create a copy of PartnerApplication
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? partnerId = null,
    Object? userId = null,
    Object? createdAt = freezed,
    Object? approvedAt = freezed,
    Object? rejectedAt = freezed,
    Object? declineReason = freezed,
    Object? surveyResponses = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      partnerId: null == partnerId
          ? _self.partnerId
          : partnerId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      approvedAt: freezed == approvedAt
          ? _self.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rejectedAt: freezed == rejectedAt
          ? _self.rejectedAt
          : rejectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      declineReason: freezed == declineReason
          ? _self.declineReason
          : declineReason // ignore: cast_nullable_to_non_nullable
              as String?,
      surveyResponses: null == surveyResponses
          ? _self.surveyResponses
          : surveyResponses // ignore: cast_nullable_to_non_nullable
              as List<PartnerSurveyResponse>,
    ));
  }
}

/// Adds pattern-matching-related methods to [PartnerApplication].
extension PartnerApplicationPatterns on PartnerApplication {
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
    TResult Function(_PartnerApplication value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PartnerApplication() when $default != null:
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
    TResult Function(_PartnerApplication value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PartnerApplication():
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
    TResult? Function(_PartnerApplication value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PartnerApplication() when $default != null:
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
            int id,
            @JsonKey(name: 'partner_id') String partnerId,
            @JsonKey(name: 'user_id') String userId,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'approved_at') DateTime? approvedAt,
            @JsonKey(name: 'rejected_at') DateTime? rejectedAt,
            @JsonKey(name: 'decline_reason') String? declineReason,
            @PartnerSurveyResponseConverter()
            @JsonKey(name: 'survey_responses')
            List<PartnerSurveyResponse> surveyResponses)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PartnerApplication() when $default != null:
        return $default(
            _that.id,
            _that.partnerId,
            _that.userId,
            _that.createdAt,
            _that.approvedAt,
            _that.rejectedAt,
            _that.declineReason,
            _that.surveyResponses);
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
            int id,
            @JsonKey(name: 'partner_id') String partnerId,
            @JsonKey(name: 'user_id') String userId,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'approved_at') DateTime? approvedAt,
            @JsonKey(name: 'rejected_at') DateTime? rejectedAt,
            @JsonKey(name: 'decline_reason') String? declineReason,
            @PartnerSurveyResponseConverter()
            @JsonKey(name: 'survey_responses')
            List<PartnerSurveyResponse> surveyResponses)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PartnerApplication():
        return $default(
            _that.id,
            _that.partnerId,
            _that.userId,
            _that.createdAt,
            _that.approvedAt,
            _that.rejectedAt,
            _that.declineReason,
            _that.surveyResponses);
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
            int id,
            @JsonKey(name: 'partner_id') String partnerId,
            @JsonKey(name: 'user_id') String userId,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'approved_at') DateTime? approvedAt,
            @JsonKey(name: 'rejected_at') DateTime? rejectedAt,
            @JsonKey(name: 'decline_reason') String? declineReason,
            @PartnerSurveyResponseConverter()
            @JsonKey(name: 'survey_responses')
            List<PartnerSurveyResponse> surveyResponses)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PartnerApplication() when $default != null:
        return $default(
            _that.id,
            _that.partnerId,
            _that.userId,
            _that.createdAt,
            _that.approvedAt,
            _that.rejectedAt,
            _that.declineReason,
            _that.surveyResponses);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PartnerApplication extends PartnerApplication
    with DiagnosticableTreeMixin {
  const _PartnerApplication(
      {required this.id,
      @JsonKey(name: 'partner_id') required this.partnerId,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'approved_at') this.approvedAt,
      @JsonKey(name: 'rejected_at') this.rejectedAt,
      @JsonKey(name: 'decline_reason') this.declineReason,
      @PartnerSurveyResponseConverter()
      @JsonKey(name: 'survey_responses')
      required final List<PartnerSurveyResponse> surveyResponses})
      : _surveyResponses = surveyResponses,
        super._();
  factory _PartnerApplication.fromJson(Map<String, dynamic> json) =>
      _$PartnerApplicationFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'partner_id')
  final String partnerId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'approved_at')
  final DateTime? approvedAt;
  @override
  @JsonKey(name: 'rejected_at')
  final DateTime? rejectedAt;

  /// Why the reviewer declined it (shown to the applicant).
  @override
  @JsonKey(name: 'decline_reason')
  final String? declineReason;
  final List<PartnerSurveyResponse> _surveyResponses;
  @override
  @PartnerSurveyResponseConverter()
  @JsonKey(name: 'survey_responses')
  List<PartnerSurveyResponse> get surveyResponses {
    if (_surveyResponses is EqualUnmodifiableListView) return _surveyResponses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_surveyResponses);
  }

  /// Create a copy of PartnerApplication
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PartnerApplicationCopyWith<_PartnerApplication> get copyWith =>
      __$PartnerApplicationCopyWithImpl<_PartnerApplication>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PartnerApplicationToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'PartnerApplication'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('partnerId', partnerId))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('approvedAt', approvedAt))
      ..add(DiagnosticsProperty('rejectedAt', rejectedAt))
      ..add(DiagnosticsProperty('declineReason', declineReason))
      ..add(DiagnosticsProperty('surveyResponses', surveyResponses));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PartnerApplication &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.partnerId, partnerId) ||
                other.partnerId == partnerId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.rejectedAt, rejectedAt) ||
                other.rejectedAt == rejectedAt) &&
            (identical(other.declineReason, declineReason) ||
                other.declineReason == declineReason) &&
            const DeepCollectionEquality()
                .equals(other._surveyResponses, _surveyResponses));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      partnerId,
      userId,
      createdAt,
      approvedAt,
      rejectedAt,
      declineReason,
      const DeepCollectionEquality().hash(_surveyResponses));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PartnerApplication(id: $id, partnerId: $partnerId, userId: $userId, createdAt: $createdAt, approvedAt: $approvedAt, rejectedAt: $rejectedAt, declineReason: $declineReason, surveyResponses: $surveyResponses)';
  }
}

/// @nodoc
abstract mixin class _$PartnerApplicationCopyWith<$Res>
    implements $PartnerApplicationCopyWith<$Res> {
  factory _$PartnerApplicationCopyWith(
          _PartnerApplication value, $Res Function(_PartnerApplication) _then) =
      __$PartnerApplicationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'partner_id') String partnerId,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'approved_at') DateTime? approvedAt,
      @JsonKey(name: 'rejected_at') DateTime? rejectedAt,
      @JsonKey(name: 'decline_reason') String? declineReason,
      @PartnerSurveyResponseConverter()
      @JsonKey(name: 'survey_responses')
      List<PartnerSurveyResponse> surveyResponses});
}

/// @nodoc
class __$PartnerApplicationCopyWithImpl<$Res>
    implements _$PartnerApplicationCopyWith<$Res> {
  __$PartnerApplicationCopyWithImpl(this._self, this._then);

  final _PartnerApplication _self;
  final $Res Function(_PartnerApplication) _then;

  /// Create a copy of PartnerApplication
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? partnerId = null,
    Object? userId = null,
    Object? createdAt = freezed,
    Object? approvedAt = freezed,
    Object? rejectedAt = freezed,
    Object? declineReason = freezed,
    Object? surveyResponses = null,
  }) {
    return _then(_PartnerApplication(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      partnerId: null == partnerId
          ? _self.partnerId
          : partnerId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      approvedAt: freezed == approvedAt
          ? _self.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rejectedAt: freezed == rejectedAt
          ? _self.rejectedAt
          : rejectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      declineReason: freezed == declineReason
          ? _self.declineReason
          : declineReason // ignore: cast_nullable_to_non_nullable
              as String?,
      surveyResponses: null == surveyResponses
          ? _self._surveyResponses
          : surveyResponses // ignore: cast_nullable_to_non_nullable
              as List<PartnerSurveyResponse>,
    ));
  }
}

// dart format on
