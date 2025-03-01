// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner_survey.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PartnerSurvey {
  int get index;
  @JsonKey(name: 'survey_id')
  String get surveyId;

  /// Create a copy of PartnerSurvey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PartnerSurveyCopyWith<PartnerSurvey> get copyWith =>
      _$PartnerSurveyCopyWithImpl<PartnerSurvey>(
          this as PartnerSurvey, _$identity);

  /// Serializes this PartnerSurvey to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PartnerSurvey &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.surveyId, surveyId) ||
                other.surveyId == surveyId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, index, surveyId);

  @override
  String toString() {
    return 'PartnerSurvey(index: $index, surveyId: $surveyId)';
  }
}

/// @nodoc
abstract mixin class $PartnerSurveyCopyWith<$Res> {
  factory $PartnerSurveyCopyWith(
          PartnerSurvey value, $Res Function(PartnerSurvey) _then) =
      _$PartnerSurveyCopyWithImpl;
  @useResult
  $Res call({int index, @JsonKey(name: 'survey_id') String surveyId});
}

/// @nodoc
class _$PartnerSurveyCopyWithImpl<$Res>
    implements $PartnerSurveyCopyWith<$Res> {
  _$PartnerSurveyCopyWithImpl(this._self, this._then);

  final PartnerSurvey _self;
  final $Res Function(PartnerSurvey) _then;

  /// Create a copy of PartnerSurvey
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? surveyId = null,
  }) {
    return _then(_self.copyWith(
      index: null == index
          ? _self.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      surveyId: null == surveyId
          ? _self.surveyId
          : surveyId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PartnerSurvey implements PartnerSurvey {
  const _PartnerSurvey(
      {required this.index,
      @JsonKey(name: 'survey_id') required this.surveyId});
  factory _PartnerSurvey.fromJson(Map<String, dynamic> json) =>
      _$PartnerSurveyFromJson(json);

  @override
  final int index;
  @override
  @JsonKey(name: 'survey_id')
  final String surveyId;

  /// Create a copy of PartnerSurvey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PartnerSurveyCopyWith<_PartnerSurvey> get copyWith =>
      __$PartnerSurveyCopyWithImpl<_PartnerSurvey>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PartnerSurveyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PartnerSurvey &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.surveyId, surveyId) ||
                other.surveyId == surveyId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, index, surveyId);

  @override
  String toString() {
    return 'PartnerSurvey(index: $index, surveyId: $surveyId)';
  }
}

/// @nodoc
abstract mixin class _$PartnerSurveyCopyWith<$Res>
    implements $PartnerSurveyCopyWith<$Res> {
  factory _$PartnerSurveyCopyWith(
          _PartnerSurvey value, $Res Function(_PartnerSurvey) _then) =
      __$PartnerSurveyCopyWithImpl;
  @override
  @useResult
  $Res call({int index, @JsonKey(name: 'survey_id') String surveyId});
}

/// @nodoc
class __$PartnerSurveyCopyWithImpl<$Res>
    implements _$PartnerSurveyCopyWith<$Res> {
  __$PartnerSurveyCopyWithImpl(this._self, this._then);

  final _PartnerSurvey _self;
  final $Res Function(_PartnerSurvey) _then;

  /// Create a copy of PartnerSurvey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? index = null,
    Object? surveyId = null,
  }) {
    return _then(_PartnerSurvey(
      index: null == index
          ? _self.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      surveyId: null == surveyId
          ? _self.surveyId
          : surveyId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
