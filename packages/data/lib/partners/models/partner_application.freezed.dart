// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner_application.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartnerApplication _$PartnerApplicationFromJson(Map<String, dynamic> json) {
  return _PartnerApplication.fromJson(json);
}

/// @nodoc
mixin _$PartnerApplication {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'partner_id')
  String get partnerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'approved_at')
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  @PartnerSurveyResponseConverter()
  @JsonKey(name: 'survey_responses')
  List<PartnerSurveyResponse> get surveyResponses =>
      throw _privateConstructorUsedError;

  /// Serializes this PartnerApplication to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartnerApplication
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartnerApplicationCopyWith<PartnerApplication> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartnerApplicationCopyWith<$Res> {
  factory $PartnerApplicationCopyWith(
          PartnerApplication value, $Res Function(PartnerApplication) then) =
      _$PartnerApplicationCopyWithImpl<$Res, PartnerApplication>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'partner_id') String partnerId,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'approved_at') DateTime? approvedAt,
      @PartnerSurveyResponseConverter()
      @JsonKey(name: 'survey_responses')
      List<PartnerSurveyResponse> surveyResponses});
}

/// @nodoc
class _$PartnerApplicationCopyWithImpl<$Res, $Val extends PartnerApplication>
    implements $PartnerApplicationCopyWith<$Res> {
  _$PartnerApplicationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    Object? surveyResponses = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      partnerId: null == partnerId
          ? _value.partnerId
          : partnerId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      surveyResponses: null == surveyResponses
          ? _value.surveyResponses
          : surveyResponses // ignore: cast_nullable_to_non_nullable
              as List<PartnerSurveyResponse>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartnerApplicationImplCopyWith<$Res>
    implements $PartnerApplicationCopyWith<$Res> {
  factory _$$PartnerApplicationImplCopyWith(_$PartnerApplicationImpl value,
          $Res Function(_$PartnerApplicationImpl) then) =
      __$$PartnerApplicationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'partner_id') String partnerId,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'approved_at') DateTime? approvedAt,
      @PartnerSurveyResponseConverter()
      @JsonKey(name: 'survey_responses')
      List<PartnerSurveyResponse> surveyResponses});
}

/// @nodoc
class __$$PartnerApplicationImplCopyWithImpl<$Res>
    extends _$PartnerApplicationCopyWithImpl<$Res, _$PartnerApplicationImpl>
    implements _$$PartnerApplicationImplCopyWith<$Res> {
  __$$PartnerApplicationImplCopyWithImpl(_$PartnerApplicationImpl _value,
      $Res Function(_$PartnerApplicationImpl) _then)
      : super(_value, _then);

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
    Object? surveyResponses = null,
  }) {
    return _then(_$PartnerApplicationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      partnerId: null == partnerId
          ? _value.partnerId
          : partnerId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      surveyResponses: null == surveyResponses
          ? _value._surveyResponses
          : surveyResponses // ignore: cast_nullable_to_non_nullable
              as List<PartnerSurveyResponse>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartnerApplicationImpl
    with DiagnosticableTreeMixin
    implements _PartnerApplication {
  const _$PartnerApplicationImpl(
      {required this.id,
      @JsonKey(name: 'partner_id') required this.partnerId,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'approved_at') this.approvedAt,
      @PartnerSurveyResponseConverter()
      @JsonKey(name: 'survey_responses')
      required final List<PartnerSurveyResponse> surveyResponses})
      : _surveyResponses = surveyResponses;

  factory _$PartnerApplicationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartnerApplicationImplFromJson(json);

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
  final List<PartnerSurveyResponse> _surveyResponses;
  @override
  @PartnerSurveyResponseConverter()
  @JsonKey(name: 'survey_responses')
  List<PartnerSurveyResponse> get surveyResponses {
    if (_surveyResponses is EqualUnmodifiableListView) return _surveyResponses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_surveyResponses);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PartnerApplication(id: $id, partnerId: $partnerId, userId: $userId, createdAt: $createdAt, approvedAt: $approvedAt, surveyResponses: $surveyResponses)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PartnerApplication'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('partnerId', partnerId))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('approvedAt', approvedAt))
      ..add(DiagnosticsProperty('surveyResponses', surveyResponses));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartnerApplicationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.partnerId, partnerId) ||
                other.partnerId == partnerId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            const DeepCollectionEquality()
                .equals(other._surveyResponses, _surveyResponses));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, partnerId, userId, createdAt,
      approvedAt, const DeepCollectionEquality().hash(_surveyResponses));

  /// Create a copy of PartnerApplication
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartnerApplicationImplCopyWith<_$PartnerApplicationImpl> get copyWith =>
      __$$PartnerApplicationImplCopyWithImpl<_$PartnerApplicationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartnerApplicationImplToJson(
      this,
    );
  }
}

abstract class _PartnerApplication implements PartnerApplication {
  const factory _PartnerApplication(
          {required final int id,
          @JsonKey(name: 'partner_id') required final String partnerId,
          @JsonKey(name: 'user_id') required final String userId,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'approved_at') final DateTime? approvedAt,
          @PartnerSurveyResponseConverter()
          @JsonKey(name: 'survey_responses')
          required final List<PartnerSurveyResponse> surveyResponses}) =
      _$PartnerApplicationImpl;

  factory _PartnerApplication.fromJson(Map<String, dynamic> json) =
      _$PartnerApplicationImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'partner_id')
  String get partnerId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'approved_at')
  DateTime? get approvedAt;
  @override
  @PartnerSurveyResponseConverter()
  @JsonKey(name: 'survey_responses')
  List<PartnerSurveyResponse> get surveyResponses;

  /// Create a copy of PartnerApplication
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartnerApplicationImplCopyWith<_$PartnerApplicationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
