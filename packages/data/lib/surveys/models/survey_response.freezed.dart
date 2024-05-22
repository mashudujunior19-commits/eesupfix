// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'survey_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SurveyResponse _$SurveyResponseFromJson(Map<String, dynamic> json) {
  return _SurveyResponse.fromJson(json);
}

/// @nodoc
mixin _$SurveyResponse {
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'survey_id')
  String get surveyId => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  bool get passed => throw _privateConstructorUsedError;
  @QuestionAnswerConverter()
  List<QuestionAnswer> get answers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SurveyResponseCopyWith<SurveyResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SurveyResponseCopyWith<$Res> {
  factory $SurveyResponseCopyWith(
          SurveyResponse value, $Res Function(SurveyResponse) then) =
      _$SurveyResponseCopyWithImpl<$Res, SurveyResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'survey_id') String surveyId,
      int score,
      bool passed,
      @QuestionAnswerConverter() List<QuestionAnswer> answers});
}

/// @nodoc
class _$SurveyResponseCopyWithImpl<$Res, $Val extends SurveyResponse>
    implements $SurveyResponseCopyWith<$Res> {
  _$SurveyResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? surveyId = null,
    Object? score = null,
    Object? passed = null,
    Object? answers = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      surveyId: null == surveyId
          ? _value.surveyId
          : surveyId // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      passed: null == passed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool,
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<QuestionAnswer>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SurveyResponseImplCopyWith<$Res>
    implements $SurveyResponseCopyWith<$Res> {
  factory _$$SurveyResponseImplCopyWith(_$SurveyResponseImpl value,
          $Res Function(_$SurveyResponseImpl) then) =
      __$$SurveyResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'survey_id') String surveyId,
      int score,
      bool passed,
      @QuestionAnswerConverter() List<QuestionAnswer> answers});
}

/// @nodoc
class __$$SurveyResponseImplCopyWithImpl<$Res>
    extends _$SurveyResponseCopyWithImpl<$Res, _$SurveyResponseImpl>
    implements _$$SurveyResponseImplCopyWith<$Res> {
  __$$SurveyResponseImplCopyWithImpl(
      _$SurveyResponseImpl _value, $Res Function(_$SurveyResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? surveyId = null,
    Object? score = null,
    Object? passed = null,
    Object? answers = null,
  }) {
    return _then(_$SurveyResponseImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      surveyId: null == surveyId
          ? _value.surveyId
          : surveyId // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      passed: null == passed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool,
      answers: null == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<QuestionAnswer>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SurveyResponseImpl implements _SurveyResponse {
  const _$SurveyResponseImpl(
      {@JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'survey_id') required this.surveyId,
      required this.score,
      required this.passed,
      @QuestionAnswerConverter() required final List<QuestionAnswer> answers})
      : _answers = answers;

  factory _$SurveyResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SurveyResponseImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'survey_id')
  final String surveyId;
  @override
  final int score;
  @override
  final bool passed;
  final List<QuestionAnswer> _answers;
  @override
  @QuestionAnswerConverter()
  List<QuestionAnswer> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  @override
  String toString() {
    return 'SurveyResponse(userId: $userId, surveyId: $surveyId, score: $score, passed: $passed, answers: $answers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SurveyResponseImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.surveyId, surveyId) ||
                other.surveyId == surveyId) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.passed, passed) || other.passed == passed) &&
            const DeepCollectionEquality().equals(other._answers, _answers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, surveyId, score, passed,
      const DeepCollectionEquality().hash(_answers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SurveyResponseImplCopyWith<_$SurveyResponseImpl> get copyWith =>
      __$$SurveyResponseImplCopyWithImpl<_$SurveyResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SurveyResponseImplToJson(
      this,
    );
  }
}

abstract class _SurveyResponse implements SurveyResponse {
  const factory _SurveyResponse(
      {@JsonKey(name: 'user_id') required final String userId,
      @JsonKey(name: 'survey_id') required final String surveyId,
      required final int score,
      required final bool passed,
      @QuestionAnswerConverter()
      required final List<QuestionAnswer> answers}) = _$SurveyResponseImpl;

  factory _SurveyResponse.fromJson(Map<String, dynamic> json) =
      _$SurveyResponseImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'survey_id')
  String get surveyId;
  @override
  int get score;
  @override
  bool get passed;
  @override
  @QuestionAnswerConverter()
  List<QuestionAnswer> get answers;
  @override
  @JsonKey(ignore: true)
  _$$SurveyResponseImplCopyWith<_$SurveyResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuestionAnswer _$QuestionAnswerFromJson(Map<String, dynamic> json) {
  return _QuestionAnswer.fromJson(json);
}

/// @nodoc
mixin _$QuestionAnswer {
  @JsonKey(name: 'question_id')
  int get questionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'slider_value')
  int? get sliderValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'rating_value')
  int? get ratingValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'open_ended_answer')
  String? get openEndedAnswer => throw _privateConstructorUsedError;
  @JsonKey(name: 'recording_url')
  String? get recordingUrl => throw _privateConstructorUsedError;
  @ChoiceConverter()
  @JsonKey(name: 'options')
  List<Choice>? get options => throw _privateConstructorUsedError;
  @MediaFileConverter()
  @JsonKey(name: 'files')
  List<MediaFile>? get files => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_time')
  String? get dateTime => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  String? get time => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuestionAnswerCopyWith<QuestionAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionAnswerCopyWith<$Res> {
  factory $QuestionAnswerCopyWith(
          QuestionAnswer value, $Res Function(QuestionAnswer) then) =
      _$QuestionAnswerCopyWithImpl<$Res, QuestionAnswer>;
  @useResult
  $Res call(
      {@JsonKey(name: 'question_id') int questionId,
      @JsonKey(name: 'slider_value') int? sliderValue,
      @JsonKey(name: 'rating_value') int? ratingValue,
      @JsonKey(name: 'open_ended_answer') String? openEndedAnswer,
      @JsonKey(name: 'recording_url') String? recordingUrl,
      @ChoiceConverter() @JsonKey(name: 'options') List<Choice>? options,
      @MediaFileConverter() @JsonKey(name: 'files') List<MediaFile>? files,
      @JsonKey(name: 'date_time') String? dateTime,
      String? date,
      String? time});
}

/// @nodoc
class _$QuestionAnswerCopyWithImpl<$Res, $Val extends QuestionAnswer>
    implements $QuestionAnswerCopyWith<$Res> {
  _$QuestionAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? sliderValue = freezed,
    Object? ratingValue = freezed,
    Object? openEndedAnswer = freezed,
    Object? recordingUrl = freezed,
    Object? options = freezed,
    Object? files = freezed,
    Object? dateTime = freezed,
    Object? date = freezed,
    Object? time = freezed,
  }) {
    return _then(_value.copyWith(
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
      sliderValue: freezed == sliderValue
          ? _value.sliderValue
          : sliderValue // ignore: cast_nullable_to_non_nullable
              as int?,
      ratingValue: freezed == ratingValue
          ? _value.ratingValue
          : ratingValue // ignore: cast_nullable_to_non_nullable
              as int?,
      openEndedAnswer: freezed == openEndedAnswer
          ? _value.openEndedAnswer
          : openEndedAnswer // ignore: cast_nullable_to_non_nullable
              as String?,
      recordingUrl: freezed == recordingUrl
          ? _value.recordingUrl
          : recordingUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      options: freezed == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<Choice>?,
      files: freezed == files
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<MediaFile>?,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuestionAnswerImplCopyWith<$Res>
    implements $QuestionAnswerCopyWith<$Res> {
  factory _$$QuestionAnswerImplCopyWith(_$QuestionAnswerImpl value,
          $Res Function(_$QuestionAnswerImpl) then) =
      __$$QuestionAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'question_id') int questionId,
      @JsonKey(name: 'slider_value') int? sliderValue,
      @JsonKey(name: 'rating_value') int? ratingValue,
      @JsonKey(name: 'open_ended_answer') String? openEndedAnswer,
      @JsonKey(name: 'recording_url') String? recordingUrl,
      @ChoiceConverter() @JsonKey(name: 'options') List<Choice>? options,
      @MediaFileConverter() @JsonKey(name: 'files') List<MediaFile>? files,
      @JsonKey(name: 'date_time') String? dateTime,
      String? date,
      String? time});
}

/// @nodoc
class __$$QuestionAnswerImplCopyWithImpl<$Res>
    extends _$QuestionAnswerCopyWithImpl<$Res, _$QuestionAnswerImpl>
    implements _$$QuestionAnswerImplCopyWith<$Res> {
  __$$QuestionAnswerImplCopyWithImpl(
      _$QuestionAnswerImpl _value, $Res Function(_$QuestionAnswerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? sliderValue = freezed,
    Object? ratingValue = freezed,
    Object? openEndedAnswer = freezed,
    Object? recordingUrl = freezed,
    Object? options = freezed,
    Object? files = freezed,
    Object? dateTime = freezed,
    Object? date = freezed,
    Object? time = freezed,
  }) {
    return _then(_$QuestionAnswerImpl(
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
      sliderValue: freezed == sliderValue
          ? _value.sliderValue
          : sliderValue // ignore: cast_nullable_to_non_nullable
              as int?,
      ratingValue: freezed == ratingValue
          ? _value.ratingValue
          : ratingValue // ignore: cast_nullable_to_non_nullable
              as int?,
      openEndedAnswer: freezed == openEndedAnswer
          ? _value.openEndedAnswer
          : openEndedAnswer // ignore: cast_nullable_to_non_nullable
              as String?,
      recordingUrl: freezed == recordingUrl
          ? _value.recordingUrl
          : recordingUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      options: freezed == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<Choice>?,
      files: freezed == files
          ? _value._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<MediaFile>?,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionAnswerImpl implements _QuestionAnswer {
  const _$QuestionAnswerImpl(
      {@JsonKey(name: 'question_id') required this.questionId,
      @JsonKey(name: 'slider_value') this.sliderValue,
      @JsonKey(name: 'rating_value') this.ratingValue,
      @JsonKey(name: 'open_ended_answer') this.openEndedAnswer,
      @JsonKey(name: 'recording_url') this.recordingUrl,
      @ChoiceConverter() @JsonKey(name: 'options') final List<Choice>? options,
      @MediaFileConverter()
      @JsonKey(name: 'files')
      final List<MediaFile>? files,
      @JsonKey(name: 'date_time') this.dateTime,
      this.date,
      this.time})
      : _options = options,
        _files = files;

  factory _$QuestionAnswerImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionAnswerImplFromJson(json);

  @override
  @JsonKey(name: 'question_id')
  final int questionId;
  @override
  @JsonKey(name: 'slider_value')
  final int? sliderValue;
  @override
  @JsonKey(name: 'rating_value')
  final int? ratingValue;
  @override
  @JsonKey(name: 'open_ended_answer')
  final String? openEndedAnswer;
  @override
  @JsonKey(name: 'recording_url')
  final String? recordingUrl;
  final List<Choice>? _options;
  @override
  @ChoiceConverter()
  @JsonKey(name: 'options')
  List<Choice>? get options {
    final value = _options;
    if (value == null) return null;
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<MediaFile>? _files;
  @override
  @MediaFileConverter()
  @JsonKey(name: 'files')
  List<MediaFile>? get files {
    final value = _files;
    if (value == null) return null;
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'date_time')
  final String? dateTime;
  @override
  final String? date;
  @override
  final String? time;

  @override
  String toString() {
    return 'QuestionAnswer(questionId: $questionId, sliderValue: $sliderValue, ratingValue: $ratingValue, openEndedAnswer: $openEndedAnswer, recordingUrl: $recordingUrl, options: $options, files: $files, dateTime: $dateTime, date: $date, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionAnswerImpl &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.sliderValue, sliderValue) ||
                other.sliderValue == sliderValue) &&
            (identical(other.ratingValue, ratingValue) ||
                other.ratingValue == ratingValue) &&
            (identical(other.openEndedAnswer, openEndedAnswer) ||
                other.openEndedAnswer == openEndedAnswer) &&
            (identical(other.recordingUrl, recordingUrl) ||
                other.recordingUrl == recordingUrl) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            const DeepCollectionEquality().equals(other._files, _files) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.time, time) || other.time == time));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      questionId,
      sliderValue,
      ratingValue,
      openEndedAnswer,
      recordingUrl,
      const DeepCollectionEquality().hash(_options),
      const DeepCollectionEquality().hash(_files),
      dateTime,
      date,
      time);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionAnswerImplCopyWith<_$QuestionAnswerImpl> get copyWith =>
      __$$QuestionAnswerImplCopyWithImpl<_$QuestionAnswerImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionAnswerImplToJson(
      this,
    );
  }
}

abstract class _QuestionAnswer implements QuestionAnswer {
  const factory _QuestionAnswer(
      {@JsonKey(name: 'question_id') required final int questionId,
      @JsonKey(name: 'slider_value') final int? sliderValue,
      @JsonKey(name: 'rating_value') final int? ratingValue,
      @JsonKey(name: 'open_ended_answer') final String? openEndedAnswer,
      @JsonKey(name: 'recording_url') final String? recordingUrl,
      @ChoiceConverter() @JsonKey(name: 'options') final List<Choice>? options,
      @MediaFileConverter()
      @JsonKey(name: 'files')
      final List<MediaFile>? files,
      @JsonKey(name: 'date_time') final String? dateTime,
      final String? date,
      final String? time}) = _$QuestionAnswerImpl;

  factory _QuestionAnswer.fromJson(Map<String, dynamic> json) =
      _$QuestionAnswerImpl.fromJson;

  @override
  @JsonKey(name: 'question_id')
  int get questionId;
  @override
  @JsonKey(name: 'slider_value')
  int? get sliderValue;
  @override
  @JsonKey(name: 'rating_value')
  int? get ratingValue;
  @override
  @JsonKey(name: 'open_ended_answer')
  String? get openEndedAnswer;
  @override
  @JsonKey(name: 'recording_url')
  String? get recordingUrl;
  @override
  @ChoiceConverter()
  @JsonKey(name: 'options')
  List<Choice>? get options;
  @override
  @MediaFileConverter()
  @JsonKey(name: 'files')
  List<MediaFile>? get files;
  @override
  @JsonKey(name: 'date_time')
  String? get dateTime;
  @override
  String? get date;
  @override
  String? get time;
  @override
  @JsonKey(ignore: true)
  _$$QuestionAnswerImplCopyWith<_$QuestionAnswerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
