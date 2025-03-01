// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'survey_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SurveyResponse {
  @JsonKey(name: 'user_id')
  String get userId;
  @JsonKey(name: 'survey_id')
  String get surveyId;
  int get score;
  bool get passed;
  @QuestionAnswerConverter()
  List<QuestionAnswer> get answers;

  /// Create a copy of SurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SurveyResponseCopyWith<SurveyResponse> get copyWith =>
      _$SurveyResponseCopyWithImpl<SurveyResponse>(
          this as SurveyResponse, _$identity);

  /// Serializes this SurveyResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SurveyResponse &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.surveyId, surveyId) ||
                other.surveyId == surveyId) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.passed, passed) || other.passed == passed) &&
            const DeepCollectionEquality().equals(other.answers, answers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, surveyId, score, passed,
      const DeepCollectionEquality().hash(answers));

  @override
  String toString() {
    return 'SurveyResponse(userId: $userId, surveyId: $surveyId, score: $score, passed: $passed, answers: $answers)';
  }
}

/// @nodoc
abstract mixin class $SurveyResponseCopyWith<$Res> {
  factory $SurveyResponseCopyWith(
          SurveyResponse value, $Res Function(SurveyResponse) _then) =
      _$SurveyResponseCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'survey_id') String surveyId,
      int score,
      bool passed,
      @QuestionAnswerConverter() List<QuestionAnswer> answers});
}

/// @nodoc
class _$SurveyResponseCopyWithImpl<$Res>
    implements $SurveyResponseCopyWith<$Res> {
  _$SurveyResponseCopyWithImpl(this._self, this._then);

  final SurveyResponse _self;
  final $Res Function(SurveyResponse) _then;

  /// Create a copy of SurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? surveyId = null,
    Object? score = null,
    Object? passed = null,
    Object? answers = null,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      surveyId: null == surveyId
          ? _self.surveyId
          : surveyId // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _self.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      passed: null == passed
          ? _self.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool,
      answers: null == answers
          ? _self.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<QuestionAnswer>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SurveyResponse implements SurveyResponse {
  const _SurveyResponse(
      {@JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'survey_id') required this.surveyId,
      required this.score,
      required this.passed,
      @QuestionAnswerConverter() required final List<QuestionAnswer> answers})
      : _answers = answers;
  factory _SurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFromJson(json);

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

  /// Create a copy of SurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SurveyResponseCopyWith<_SurveyResponse> get copyWith =>
      __$SurveyResponseCopyWithImpl<_SurveyResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SurveyResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SurveyResponse &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.surveyId, surveyId) ||
                other.surveyId == surveyId) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.passed, passed) || other.passed == passed) &&
            const DeepCollectionEquality().equals(other._answers, _answers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, surveyId, score, passed,
      const DeepCollectionEquality().hash(_answers));

  @override
  String toString() {
    return 'SurveyResponse(userId: $userId, surveyId: $surveyId, score: $score, passed: $passed, answers: $answers)';
  }
}

/// @nodoc
abstract mixin class _$SurveyResponseCopyWith<$Res>
    implements $SurveyResponseCopyWith<$Res> {
  factory _$SurveyResponseCopyWith(
          _SurveyResponse value, $Res Function(_SurveyResponse) _then) =
      __$SurveyResponseCopyWithImpl;
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
class __$SurveyResponseCopyWithImpl<$Res>
    implements _$SurveyResponseCopyWith<$Res> {
  __$SurveyResponseCopyWithImpl(this._self, this._then);

  final _SurveyResponse _self;
  final $Res Function(_SurveyResponse) _then;

  /// Create a copy of SurveyResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? surveyId = null,
    Object? score = null,
    Object? passed = null,
    Object? answers = null,
  }) {
    return _then(_SurveyResponse(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      surveyId: null == surveyId
          ? _self.surveyId
          : surveyId // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _self.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      passed: null == passed
          ? _self.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool,
      answers: null == answers
          ? _self._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<QuestionAnswer>,
    ));
  }
}

/// @nodoc
mixin _$QuestionAnswer {
  @JsonKey(name: 'question_id')
  int get questionId;
  @JsonKey(name: 'slider_value')
  int? get sliderValue;
  @JsonKey(name: 'rating_value')
  int? get ratingValue;
  @JsonKey(name: 'open_ended_answer')
  String? get openEndedAnswer;
  @JsonKey(name: 'recording_url')
  String? get recordingUrl;
  @ChoiceConverter()
  @JsonKey(name: 'options')
  List<Choice>? get options;
  @MediaFileConverter()
  @JsonKey(name: 'files')
  List<MediaFile>? get files;
  @JsonKey(name: 'date_time')
  String? get dateTime;
  String? get date;
  String? get time;

  /// Create a copy of QuestionAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuestionAnswerCopyWith<QuestionAnswer> get copyWith =>
      _$QuestionAnswerCopyWithImpl<QuestionAnswer>(
          this as QuestionAnswer, _$identity);

  /// Serializes this QuestionAnswer to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QuestionAnswer &&
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
            const DeepCollectionEquality().equals(other.options, options) &&
            const DeepCollectionEquality().equals(other.files, files) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.time, time) || other.time == time));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      questionId,
      sliderValue,
      ratingValue,
      openEndedAnswer,
      recordingUrl,
      const DeepCollectionEquality().hash(options),
      const DeepCollectionEquality().hash(files),
      dateTime,
      date,
      time);

  @override
  String toString() {
    return 'QuestionAnswer(questionId: $questionId, sliderValue: $sliderValue, ratingValue: $ratingValue, openEndedAnswer: $openEndedAnswer, recordingUrl: $recordingUrl, options: $options, files: $files, dateTime: $dateTime, date: $date, time: $time)';
  }
}

/// @nodoc
abstract mixin class $QuestionAnswerCopyWith<$Res> {
  factory $QuestionAnswerCopyWith(
          QuestionAnswer value, $Res Function(QuestionAnswer) _then) =
      _$QuestionAnswerCopyWithImpl;
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
class _$QuestionAnswerCopyWithImpl<$Res>
    implements $QuestionAnswerCopyWith<$Res> {
  _$QuestionAnswerCopyWithImpl(this._self, this._then);

  final QuestionAnswer _self;
  final $Res Function(QuestionAnswer) _then;

  /// Create a copy of QuestionAnswer
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      questionId: null == questionId
          ? _self.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
      sliderValue: freezed == sliderValue
          ? _self.sliderValue
          : sliderValue // ignore: cast_nullable_to_non_nullable
              as int?,
      ratingValue: freezed == ratingValue
          ? _self.ratingValue
          : ratingValue // ignore: cast_nullable_to_non_nullable
              as int?,
      openEndedAnswer: freezed == openEndedAnswer
          ? _self.openEndedAnswer
          : openEndedAnswer // ignore: cast_nullable_to_non_nullable
              as String?,
      recordingUrl: freezed == recordingUrl
          ? _self.recordingUrl
          : recordingUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      options: freezed == options
          ? _self.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<Choice>?,
      files: freezed == files
          ? _self.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<MediaFile>?,
      dateTime: freezed == dateTime
          ? _self.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _self.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _QuestionAnswer implements QuestionAnswer {
  const _QuestionAnswer(
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
  factory _QuestionAnswer.fromJson(Map<String, dynamic> json) =>
      _$QuestionAnswerFromJson(json);

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

  /// Create a copy of QuestionAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuestionAnswerCopyWith<_QuestionAnswer> get copyWith =>
      __$QuestionAnswerCopyWithImpl<_QuestionAnswer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QuestionAnswerToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuestionAnswer &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString() {
    return 'QuestionAnswer(questionId: $questionId, sliderValue: $sliderValue, ratingValue: $ratingValue, openEndedAnswer: $openEndedAnswer, recordingUrl: $recordingUrl, options: $options, files: $files, dateTime: $dateTime, date: $date, time: $time)';
  }
}

/// @nodoc
abstract mixin class _$QuestionAnswerCopyWith<$Res>
    implements $QuestionAnswerCopyWith<$Res> {
  factory _$QuestionAnswerCopyWith(
          _QuestionAnswer value, $Res Function(_QuestionAnswer) _then) =
      __$QuestionAnswerCopyWithImpl;
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
class __$QuestionAnswerCopyWithImpl<$Res>
    implements _$QuestionAnswerCopyWith<$Res> {
  __$QuestionAnswerCopyWithImpl(this._self, this._then);

  final _QuestionAnswer _self;
  final $Res Function(_QuestionAnswer) _then;

  /// Create a copy of QuestionAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_QuestionAnswer(
      questionId: null == questionId
          ? _self.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
      sliderValue: freezed == sliderValue
          ? _self.sliderValue
          : sliderValue // ignore: cast_nullable_to_non_nullable
              as int?,
      ratingValue: freezed == ratingValue
          ? _self.ratingValue
          : ratingValue // ignore: cast_nullable_to_non_nullable
              as int?,
      openEndedAnswer: freezed == openEndedAnswer
          ? _self.openEndedAnswer
          : openEndedAnswer // ignore: cast_nullable_to_non_nullable
              as String?,
      recordingUrl: freezed == recordingUrl
          ? _self.recordingUrl
          : recordingUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      options: freezed == options
          ? _self._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<Choice>?,
      files: freezed == files
          ? _self._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<MediaFile>?,
      dateTime: freezed == dateTime
          ? _self.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _self.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
