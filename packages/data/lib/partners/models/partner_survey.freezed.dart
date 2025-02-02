// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner_survey.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartnerSurvey _$PartnerSurveyFromJson(Map<String, dynamic> json) {
  return _PartnerSurvey.fromJson(json);
}

/// @nodoc
mixin _$PartnerSurvey {
  int get index => throw _privateConstructorUsedError;
  @JsonKey(name: 'survey_id')
  String get surveyId => throw _privateConstructorUsedError;

  /// Serializes this PartnerSurvey to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartnerSurvey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartnerSurveyCopyWith<PartnerSurvey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartnerSurveyCopyWith<$Res> {
  factory $PartnerSurveyCopyWith(
          PartnerSurvey value, $Res Function(PartnerSurvey) then) =
      _$PartnerSurveyCopyWithImpl<$Res, PartnerSurvey>;
  @useResult
  $Res call({int index, @JsonKey(name: 'survey_id') String surveyId});
}

/// @nodoc
class _$PartnerSurveyCopyWithImpl<$Res, $Val extends PartnerSurvey>
    implements $PartnerSurveyCopyWith<$Res> {
  _$PartnerSurveyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartnerSurvey
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? surveyId = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartnerSurveyImplCopyWith<$Res>
    implements $PartnerSurveyCopyWith<$Res> {
  factory _$$PartnerSurveyImplCopyWith(
          _$PartnerSurveyImpl value, $Res Function(_$PartnerSurveyImpl) then) =
      __$$PartnerSurveyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int index, @JsonKey(name: 'survey_id') String surveyId});
}

/// @nodoc
class __$$PartnerSurveyImplCopyWithImpl<$Res>
    extends _$PartnerSurveyCopyWithImpl<$Res, _$PartnerSurveyImpl>
    implements _$$PartnerSurveyImplCopyWith<$Res> {
  __$$PartnerSurveyImplCopyWithImpl(
      _$PartnerSurveyImpl _value, $Res Function(_$PartnerSurveyImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartnerSurvey
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? surveyId = null,
  }) {
    return _then(_$PartnerSurveyImpl(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      surveyId: null == surveyId
          ? _value.surveyId
          : surveyId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartnerSurveyImpl implements _PartnerSurvey {
  const _$PartnerSurveyImpl(
      {required this.index,
      @JsonKey(name: 'survey_id') required this.surveyId});

  factory _$PartnerSurveyImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartnerSurveyImplFromJson(json);

  @override
  final int index;
  @override
  @JsonKey(name: 'survey_id')
  final String surveyId;

  @override
  String toString() {
    return 'PartnerSurvey(index: $index, surveyId: $surveyId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartnerSurveyImpl &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.surveyId, surveyId) ||
                other.surveyId == surveyId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, index, surveyId);

  /// Create a copy of PartnerSurvey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartnerSurveyImplCopyWith<_$PartnerSurveyImpl> get copyWith =>
      __$$PartnerSurveyImplCopyWithImpl<_$PartnerSurveyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartnerSurveyImplToJson(
      this,
    );
  }
}

abstract class _PartnerSurvey implements PartnerSurvey {
  const factory _PartnerSurvey(
          {required final int index,
          @JsonKey(name: 'survey_id') required final String surveyId}) =
      _$PartnerSurveyImpl;

  factory _PartnerSurvey.fromJson(Map<String, dynamic> json) =
      _$PartnerSurveyImpl.fromJson;

  @override
  int get index;
  @override
  @JsonKey(name: 'survey_id')
  String get surveyId;

  /// Create a copy of PartnerSurvey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartnerSurveyImplCopyWith<_$PartnerSurveyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
