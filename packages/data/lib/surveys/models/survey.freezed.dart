// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'survey.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Survey implements DiagnosticableTreeMixin {
  String get id;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @QuestionConverter()
  List<Question> get questions;
  String get title;
  String? get description;
  String? get wallet;
  @SurveyTypeConverter()
  SurveyType get type;
  @JsonKey(name: 'max_responses')
  int? get maxResponses;
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @JsonKey(name: 'video_url')
  String? get videoUrl;
  @JsonKey(name: 'reward_amount')
  double? get rewardAmount;
  int? get duration;
  int? get points;
  @JsonKey(name: 'responded_at', includeToJson: false)
  DateTime? get respondedAt;
  @JsonKey(name: 'pass_percentage')
  double? get passPercentage;
  @JsonKey(name: 'enable_scoring')
  bool? get enableScoring;
  @JsonKey(name: 'require_all')
  bool? get requireAll;
  @JsonKey(name: 'enforce_time_limit')
  bool? get enforceTimeLimit;
  @SurveyConverter()
  @JsonKey(name: 'pre_survey')
  Survey? get preSurvey;
  bool? get passed;
  int? get score;

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SurveyCopyWith<Survey> get copyWith =>
      _$SurveyCopyWithImpl<Survey>(this as Survey, _$identity);

  /// Serializes this Survey to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'Survey'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('questions', questions))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('wallet', wallet))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('maxResponses', maxResponses))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('videoUrl', videoUrl))
      ..add(DiagnosticsProperty('rewardAmount', rewardAmount))
      ..add(DiagnosticsProperty('duration', duration))
      ..add(DiagnosticsProperty('points', points))
      ..add(DiagnosticsProperty('respondedAt', respondedAt))
      ..add(DiagnosticsProperty('passPercentage', passPercentage))
      ..add(DiagnosticsProperty('enableScoring', enableScoring))
      ..add(DiagnosticsProperty('requireAll', requireAll))
      ..add(DiagnosticsProperty('enforceTimeLimit', enforceTimeLimit))
      ..add(DiagnosticsProperty('preSurvey', preSurvey))
      ..add(DiagnosticsProperty('passed', passed))
      ..add(DiagnosticsProperty('score', score));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Survey &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other.questions, questions) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.wallet, wallet) || other.wallet == wallet) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.maxResponses, maxResponses) ||
                other.maxResponses == maxResponses) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.rewardAmount, rewardAmount) ||
                other.rewardAmount == rewardAmount) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.respondedAt, respondedAt) ||
                other.respondedAt == respondedAt) &&
            (identical(other.passPercentage, passPercentage) ||
                other.passPercentage == passPercentage) &&
            (identical(other.enableScoring, enableScoring) ||
                other.enableScoring == enableScoring) &&
            (identical(other.requireAll, requireAll) ||
                other.requireAll == requireAll) &&
            (identical(other.enforceTimeLimit, enforceTimeLimit) ||
                other.enforceTimeLimit == enforceTimeLimit) &&
            (identical(other.preSurvey, preSurvey) ||
                other.preSurvey == preSurvey) &&
            (identical(other.passed, passed) || other.passed == passed) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        createdAt,
        const DeepCollectionEquality().hash(questions),
        title,
        description,
        wallet,
        type,
        maxResponses,
        imageUrl,
        videoUrl,
        rewardAmount,
        duration,
        points,
        respondedAt,
        passPercentage,
        enableScoring,
        requireAll,
        enforceTimeLimit,
        preSurvey,
        passed,
        score
      ]);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Survey(id: $id, createdAt: $createdAt, questions: $questions, title: $title, description: $description, wallet: $wallet, type: $type, maxResponses: $maxResponses, imageUrl: $imageUrl, videoUrl: $videoUrl, rewardAmount: $rewardAmount, duration: $duration, points: $points, respondedAt: $respondedAt, passPercentage: $passPercentage, enableScoring: $enableScoring, requireAll: $requireAll, enforceTimeLimit: $enforceTimeLimit, preSurvey: $preSurvey, passed: $passed, score: $score)';
  }
}

/// @nodoc
abstract mixin class $SurveyCopyWith<$Res> {
  factory $SurveyCopyWith(Survey value, $Res Function(Survey) _then) =
      _$SurveyCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @QuestionConverter() List<Question> questions,
      String title,
      String? description,
      String? wallet,
      @SurveyTypeConverter() SurveyType type,
      @JsonKey(name: 'max_responses') int? maxResponses,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'video_url') String? videoUrl,
      @JsonKey(name: 'reward_amount') double? rewardAmount,
      int? duration,
      int? points,
      @JsonKey(name: 'responded_at', includeToJson: false)
      DateTime? respondedAt,
      @JsonKey(name: 'pass_percentage') double? passPercentage,
      @JsonKey(name: 'enable_scoring') bool? enableScoring,
      @JsonKey(name: 'require_all') bool? requireAll,
      @JsonKey(name: 'enforce_time_limit') bool? enforceTimeLimit,
      @SurveyConverter() @JsonKey(name: 'pre_survey') Survey? preSurvey,
      bool? passed,
      int? score});

  $SurveyCopyWith<$Res>? get preSurvey;
}

/// @nodoc
class _$SurveyCopyWithImpl<$Res> implements $SurveyCopyWith<$Res> {
  _$SurveyCopyWithImpl(this._self, this._then);

  final Survey _self;
  final $Res Function(Survey) _then;

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? questions = null,
    Object? title = null,
    Object? description = freezed,
    Object? wallet = freezed,
    Object? type = null,
    Object? maxResponses = freezed,
    Object? imageUrl = freezed,
    Object? videoUrl = freezed,
    Object? rewardAmount = freezed,
    Object? duration = freezed,
    Object? points = freezed,
    Object? respondedAt = freezed,
    Object? passPercentage = freezed,
    Object? enableScoring = freezed,
    Object? requireAll = freezed,
    Object? enforceTimeLimit = freezed,
    Object? preSurvey = freezed,
    Object? passed = freezed,
    Object? score = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      questions: null == questions
          ? _self.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Question>,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      wallet: freezed == wallet
          ? _self.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as SurveyType,
      maxResponses: freezed == maxResponses
          ? _self.maxResponses
          : maxResponses // ignore: cast_nullable_to_non_nullable
              as int?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      videoUrl: freezed == videoUrl
          ? _self.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      rewardAmount: freezed == rewardAmount
          ? _self.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      points: freezed == points
          ? _self.points
          : points // ignore: cast_nullable_to_non_nullable
              as int?,
      respondedAt: freezed == respondedAt
          ? _self.respondedAt
          : respondedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      passPercentage: freezed == passPercentage
          ? _self.passPercentage
          : passPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      enableScoring: freezed == enableScoring
          ? _self.enableScoring
          : enableScoring // ignore: cast_nullable_to_non_nullable
              as bool?,
      requireAll: freezed == requireAll
          ? _self.requireAll
          : requireAll // ignore: cast_nullable_to_non_nullable
              as bool?,
      enforceTimeLimit: freezed == enforceTimeLimit
          ? _self.enforceTimeLimit
          : enforceTimeLimit // ignore: cast_nullable_to_non_nullable
              as bool?,
      preSurvey: freezed == preSurvey
          ? _self.preSurvey
          : preSurvey // ignore: cast_nullable_to_non_nullable
              as Survey?,
      passed: freezed == passed
          ? _self.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool?,
      score: freezed == score
          ? _self.score
          : score // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SurveyCopyWith<$Res>? get preSurvey {
    if (_self.preSurvey == null) {
      return null;
    }

    return $SurveyCopyWith<$Res>(_self.preSurvey!, (value) {
      return _then(_self.copyWith(preSurvey: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _Survey with DiagnosticableTreeMixin implements Survey {
  const _Survey(
      {required this.id,
      @JsonKey(name: 'created_at') required this.createdAt,
      @QuestionConverter() required final List<Question> questions,
      required this.title,
      this.description,
      this.wallet,
      @SurveyTypeConverter() required this.type,
      @JsonKey(name: 'max_responses') this.maxResponses,
      @JsonKey(name: 'image_url') this.imageUrl,
      @JsonKey(name: 'video_url') this.videoUrl,
      @JsonKey(name: 'reward_amount') this.rewardAmount,
      this.duration,
      this.points,
      @JsonKey(name: 'responded_at', includeToJson: false) this.respondedAt,
      @JsonKey(name: 'pass_percentage') this.passPercentage,
      @JsonKey(name: 'enable_scoring') this.enableScoring,
      @JsonKey(name: 'require_all') this.requireAll,
      @JsonKey(name: 'enforce_time_limit') this.enforceTimeLimit,
      @SurveyConverter() @JsonKey(name: 'pre_survey') this.preSurvey,
      this.passed,
      this.score})
      : _questions = questions;
  factory _Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final List<Question> _questions;
  @override
  @QuestionConverter()
  List<Question> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  final String title;
  @override
  final String? description;
  @override
  final String? wallet;
  @override
  @SurveyTypeConverter()
  final SurveyType type;
  @override
  @JsonKey(name: 'max_responses')
  final int? maxResponses;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'video_url')
  final String? videoUrl;
  @override
  @JsonKey(name: 'reward_amount')
  final double? rewardAmount;
  @override
  final int? duration;
  @override
  final int? points;
  @override
  @JsonKey(name: 'responded_at', includeToJson: false)
  final DateTime? respondedAt;
  @override
  @JsonKey(name: 'pass_percentage')
  final double? passPercentage;
  @override
  @JsonKey(name: 'enable_scoring')
  final bool? enableScoring;
  @override
  @JsonKey(name: 'require_all')
  final bool? requireAll;
  @override
  @JsonKey(name: 'enforce_time_limit')
  final bool? enforceTimeLimit;
  @override
  @SurveyConverter()
  @JsonKey(name: 'pre_survey')
  final Survey? preSurvey;
  @override
  final bool? passed;
  @override
  final int? score;

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SurveyCopyWith<_Survey> get copyWith =>
      __$SurveyCopyWithImpl<_Survey>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SurveyToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'Survey'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('questions', questions))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('wallet', wallet))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('maxResponses', maxResponses))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('videoUrl', videoUrl))
      ..add(DiagnosticsProperty('rewardAmount', rewardAmount))
      ..add(DiagnosticsProperty('duration', duration))
      ..add(DiagnosticsProperty('points', points))
      ..add(DiagnosticsProperty('respondedAt', respondedAt))
      ..add(DiagnosticsProperty('passPercentage', passPercentage))
      ..add(DiagnosticsProperty('enableScoring', enableScoring))
      ..add(DiagnosticsProperty('requireAll', requireAll))
      ..add(DiagnosticsProperty('enforceTimeLimit', enforceTimeLimit))
      ..add(DiagnosticsProperty('preSurvey', preSurvey))
      ..add(DiagnosticsProperty('passed', passed))
      ..add(DiagnosticsProperty('score', score));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Survey &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.wallet, wallet) || other.wallet == wallet) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.maxResponses, maxResponses) ||
                other.maxResponses == maxResponses) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.rewardAmount, rewardAmount) ||
                other.rewardAmount == rewardAmount) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.respondedAt, respondedAt) ||
                other.respondedAt == respondedAt) &&
            (identical(other.passPercentage, passPercentage) ||
                other.passPercentage == passPercentage) &&
            (identical(other.enableScoring, enableScoring) ||
                other.enableScoring == enableScoring) &&
            (identical(other.requireAll, requireAll) ||
                other.requireAll == requireAll) &&
            (identical(other.enforceTimeLimit, enforceTimeLimit) ||
                other.enforceTimeLimit == enforceTimeLimit) &&
            (identical(other.preSurvey, preSurvey) ||
                other.preSurvey == preSurvey) &&
            (identical(other.passed, passed) || other.passed == passed) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        createdAt,
        const DeepCollectionEquality().hash(_questions),
        title,
        description,
        wallet,
        type,
        maxResponses,
        imageUrl,
        videoUrl,
        rewardAmount,
        duration,
        points,
        respondedAt,
        passPercentage,
        enableScoring,
        requireAll,
        enforceTimeLimit,
        preSurvey,
        passed,
        score
      ]);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Survey(id: $id, createdAt: $createdAt, questions: $questions, title: $title, description: $description, wallet: $wallet, type: $type, maxResponses: $maxResponses, imageUrl: $imageUrl, videoUrl: $videoUrl, rewardAmount: $rewardAmount, duration: $duration, points: $points, respondedAt: $respondedAt, passPercentage: $passPercentage, enableScoring: $enableScoring, requireAll: $requireAll, enforceTimeLimit: $enforceTimeLimit, preSurvey: $preSurvey, passed: $passed, score: $score)';
  }
}

/// @nodoc
abstract mixin class _$SurveyCopyWith<$Res> implements $SurveyCopyWith<$Res> {
  factory _$SurveyCopyWith(_Survey value, $Res Function(_Survey) _then) =
      __$SurveyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @QuestionConverter() List<Question> questions,
      String title,
      String? description,
      String? wallet,
      @SurveyTypeConverter() SurveyType type,
      @JsonKey(name: 'max_responses') int? maxResponses,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'video_url') String? videoUrl,
      @JsonKey(name: 'reward_amount') double? rewardAmount,
      int? duration,
      int? points,
      @JsonKey(name: 'responded_at', includeToJson: false)
      DateTime? respondedAt,
      @JsonKey(name: 'pass_percentage') double? passPercentage,
      @JsonKey(name: 'enable_scoring') bool? enableScoring,
      @JsonKey(name: 'require_all') bool? requireAll,
      @JsonKey(name: 'enforce_time_limit') bool? enforceTimeLimit,
      @SurveyConverter() @JsonKey(name: 'pre_survey') Survey? preSurvey,
      bool? passed,
      int? score});

  @override
  $SurveyCopyWith<$Res>? get preSurvey;
}

/// @nodoc
class __$SurveyCopyWithImpl<$Res> implements _$SurveyCopyWith<$Res> {
  __$SurveyCopyWithImpl(this._self, this._then);

  final _Survey _self;
  final $Res Function(_Survey) _then;

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? questions = null,
    Object? title = null,
    Object? description = freezed,
    Object? wallet = freezed,
    Object? type = null,
    Object? maxResponses = freezed,
    Object? imageUrl = freezed,
    Object? videoUrl = freezed,
    Object? rewardAmount = freezed,
    Object? duration = freezed,
    Object? points = freezed,
    Object? respondedAt = freezed,
    Object? passPercentage = freezed,
    Object? enableScoring = freezed,
    Object? requireAll = freezed,
    Object? enforceTimeLimit = freezed,
    Object? preSurvey = freezed,
    Object? passed = freezed,
    Object? score = freezed,
  }) {
    return _then(_Survey(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      questions: null == questions
          ? _self._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Question>,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      wallet: freezed == wallet
          ? _self.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as SurveyType,
      maxResponses: freezed == maxResponses
          ? _self.maxResponses
          : maxResponses // ignore: cast_nullable_to_non_nullable
              as int?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      videoUrl: freezed == videoUrl
          ? _self.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      rewardAmount: freezed == rewardAmount
          ? _self.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      points: freezed == points
          ? _self.points
          : points // ignore: cast_nullable_to_non_nullable
              as int?,
      respondedAt: freezed == respondedAt
          ? _self.respondedAt
          : respondedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      passPercentage: freezed == passPercentage
          ? _self.passPercentage
          : passPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      enableScoring: freezed == enableScoring
          ? _self.enableScoring
          : enableScoring // ignore: cast_nullable_to_non_nullable
              as bool?,
      requireAll: freezed == requireAll
          ? _self.requireAll
          : requireAll // ignore: cast_nullable_to_non_nullable
              as bool?,
      enforceTimeLimit: freezed == enforceTimeLimit
          ? _self.enforceTimeLimit
          : enforceTimeLimit // ignore: cast_nullable_to_non_nullable
              as bool?,
      preSurvey: freezed == preSurvey
          ? _self.preSurvey
          : preSurvey // ignore: cast_nullable_to_non_nullable
              as Survey?,
      passed: freezed == passed
          ? _self.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool?,
      score: freezed == score
          ? _self.score
          : score // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SurveyCopyWith<$Res>? get preSurvey {
    if (_self.preSurvey == null) {
      return null;
    }

    return $SurveyCopyWith<$Res>(_self.preSurvey!, (value) {
      return _then(_self.copyWith(preSurvey: value));
    });
  }
}

// dart format on
