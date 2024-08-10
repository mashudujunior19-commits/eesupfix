// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner_survey_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartnerSurveyResponse _$PartnerSurveyResponseFromJson(
    Map<String, dynamic> json) {
  return _PartnerSurveyResponse.fromJson(json);
}

/// @nodoc
mixin _$PartnerSurveyResponse {
  int get index => throw _privateConstructorUsedError;
  @JsonKey(name: 'survey_id')
  String get surveyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'response_id')
  String get responseId => throw _privateConstructorUsedError;

  /// Serializes this PartnerSurveyResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartnerSurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartnerSurveyResponseCopyWith<PartnerSurveyResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartnerSurveyResponseCopyWith<$Res> {
  factory $PartnerSurveyResponseCopyWith(PartnerSurveyResponse value,
          $Res Function(PartnerSurveyResponse) then) =
      _$PartnerSurveyResponseCopyWithImpl<$Res, PartnerSurveyResponse>;
  @useResult
  $Res call(
      {int index,
      @JsonKey(name: 'survey_id') String surveyId,
      @JsonKey(name: 'response_id') String responseId});
}

/// @nodoc
class _$PartnerSurveyResponseCopyWithImpl<$Res,
        $Val extends PartnerSurveyResponse>
    implements $PartnerSurveyResponseCopyWith<$Res> {
  _$PartnerSurveyResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartnerSurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? surveyId = null,
    Object? responseId = null,
  }) {
    return _then(_value.copyWith(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      surveyId: null == surveyId
          ? _value.surveyId
          : surveyId // ignore: cast_nullable_to_non_nullable
              as String,
      responseId: null == responseId
          ? _value.responseId
          : responseId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartnerSurveyResponseImplCopyWith<$Res>
    implements $PartnerSurveyResponseCopyWith<$Res> {
  factory _$$PartnerSurveyResponseImplCopyWith(
          _$PartnerSurveyResponseImpl value,
          $Res Function(_$PartnerSurveyResponseImpl) then) =
      __$$PartnerSurveyResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int index,
      @JsonKey(name: 'survey_id') String surveyId,
      @JsonKey(name: 'response_id') String responseId});
}

/// @nodoc
class __$$PartnerSurveyResponseImplCopyWithImpl<$Res>
    extends _$PartnerSurveyResponseCopyWithImpl<$Res,
        _$PartnerSurveyResponseImpl>
    implements _$$PartnerSurveyResponseImplCopyWith<$Res> {
  __$$PartnerSurveyResponseImplCopyWithImpl(_$PartnerSurveyResponseImpl _value,
      $Res Function(_$PartnerSurveyResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartnerSurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? surveyId = null,
    Object? responseId = null,
  }) {
    return _then(_$PartnerSurveyResponseImpl(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      surveyId: null == surveyId
          ? _value.surveyId
          : surveyId // ignore: cast_nullable_to_non_nullable
              as String,
      responseId: null == responseId
          ? _value.responseId
          : responseId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartnerSurveyResponseImpl implements _PartnerSurveyResponse {
  const _$PartnerSurveyResponseImpl(
      {required this.index,
      @JsonKey(name: 'survey_id') required this.surveyId,
      @JsonKey(name: 'response_id') required this.responseId});

  factory _$PartnerSurveyResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartnerSurveyResponseImplFromJson(json);

  @override
  final int index;
  @override
  @JsonKey(name: 'survey_id')
  final String surveyId;
  @override
  @JsonKey(name: 'response_id')
  final String responseId;

  @override
  String toString() {
    return 'PartnerSurveyResponse(index: $index, surveyId: $surveyId, responseId: $responseId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartnerSurveyResponseImpl &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.surveyId, surveyId) ||
                other.surveyId == surveyId) &&
            (identical(other.responseId, responseId) ||
                other.responseId == responseId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, index, surveyId, responseId);

  /// Create a copy of PartnerSurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartnerSurveyResponseImplCopyWith<_$PartnerSurveyResponseImpl>
      get copyWith => __$$PartnerSurveyResponseImplCopyWithImpl<
          _$PartnerSurveyResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartnerSurveyResponseImplToJson(
      this,
    );
  }
}

abstract class _PartnerSurveyResponse implements PartnerSurveyResponse {
  const factory _PartnerSurveyResponse(
          {required final int index,
          @JsonKey(name: 'survey_id') required final String surveyId,
          @JsonKey(name: 'response_id') required final String responseId}) =
      _$PartnerSurveyResponseImpl;

  factory _PartnerSurveyResponse.fromJson(Map<String, dynamic> json) =
      _$PartnerSurveyResponseImpl.fromJson;

  @override
  int get index;
  @override
  @JsonKey(name: 'survey_id')
  String get surveyId;
  @override
  @JsonKey(name: 'response_id')
  String get responseId;

  /// Create a copy of PartnerSurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartnerSurveyResponseImplCopyWith<_$PartnerSurveyResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
