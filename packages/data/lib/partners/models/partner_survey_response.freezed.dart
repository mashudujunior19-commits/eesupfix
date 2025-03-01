// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner_survey_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PartnerSurveyResponse {
  int get index;
  @JsonKey(name: 'survey_id')
  String get surveyId;
  @JsonKey(name: 'response_id')
  String get responseId;

  /// Create a copy of PartnerSurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PartnerSurveyResponseCopyWith<PartnerSurveyResponse> get copyWith =>
      _$PartnerSurveyResponseCopyWithImpl<PartnerSurveyResponse>(
          this as PartnerSurveyResponse, _$identity);

  /// Serializes this PartnerSurveyResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PartnerSurveyResponse &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.surveyId, surveyId) ||
                other.surveyId == surveyId) &&
            (identical(other.responseId, responseId) ||
                other.responseId == responseId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, index, surveyId, responseId);

  @override
  String toString() {
    return 'PartnerSurveyResponse(index: $index, surveyId: $surveyId, responseId: $responseId)';
  }
}

/// @nodoc
abstract mixin class $PartnerSurveyResponseCopyWith<$Res> {
  factory $PartnerSurveyResponseCopyWith(PartnerSurveyResponse value,
          $Res Function(PartnerSurveyResponse) _then) =
      _$PartnerSurveyResponseCopyWithImpl;
  @useResult
  $Res call(
      {int index,
      @JsonKey(name: 'survey_id') String surveyId,
      @JsonKey(name: 'response_id') String responseId});
}

/// @nodoc
class _$PartnerSurveyResponseCopyWithImpl<$Res>
    implements $PartnerSurveyResponseCopyWith<$Res> {
  _$PartnerSurveyResponseCopyWithImpl(this._self, this._then);

  final PartnerSurveyResponse _self;
  final $Res Function(PartnerSurveyResponse) _then;

  /// Create a copy of PartnerSurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? surveyId = null,
    Object? responseId = null,
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
      responseId: null == responseId
          ? _self.responseId
          : responseId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PartnerSurveyResponse implements PartnerSurveyResponse {
  const _PartnerSurveyResponse(
      {required this.index,
      @JsonKey(name: 'survey_id') required this.surveyId,
      @JsonKey(name: 'response_id') required this.responseId});
  factory _PartnerSurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$PartnerSurveyResponseFromJson(json);

  @override
  final int index;
  @override
  @JsonKey(name: 'survey_id')
  final String surveyId;
  @override
  @JsonKey(name: 'response_id')
  final String responseId;

  /// Create a copy of PartnerSurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PartnerSurveyResponseCopyWith<_PartnerSurveyResponse> get copyWith =>
      __$PartnerSurveyResponseCopyWithImpl<_PartnerSurveyResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PartnerSurveyResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PartnerSurveyResponse &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.surveyId, surveyId) ||
                other.surveyId == surveyId) &&
            (identical(other.responseId, responseId) ||
                other.responseId == responseId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, index, surveyId, responseId);

  @override
  String toString() {
    return 'PartnerSurveyResponse(index: $index, surveyId: $surveyId, responseId: $responseId)';
  }
}

/// @nodoc
abstract mixin class _$PartnerSurveyResponseCopyWith<$Res>
    implements $PartnerSurveyResponseCopyWith<$Res> {
  factory _$PartnerSurveyResponseCopyWith(_PartnerSurveyResponse value,
          $Res Function(_PartnerSurveyResponse) _then) =
      __$PartnerSurveyResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int index,
      @JsonKey(name: 'survey_id') String surveyId,
      @JsonKey(name: 'response_id') String responseId});
}

/// @nodoc
class __$PartnerSurveyResponseCopyWithImpl<$Res>
    implements _$PartnerSurveyResponseCopyWith<$Res> {
  __$PartnerSurveyResponseCopyWithImpl(this._self, this._then);

  final _PartnerSurveyResponse _self;
  final $Res Function(_PartnerSurveyResponse) _then;

  /// Create a copy of PartnerSurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? index = null,
    Object? surveyId = null,
    Object? responseId = null,
  }) {
    return _then(_PartnerSurveyResponse(
      index: null == index
          ? _self.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      surveyId: null == surveyId
          ? _self.surveyId
          : surveyId // ignore: cast_nullable_to_non_nullable
              as String,
      responseId: null == responseId
          ? _self.responseId
          : responseId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
