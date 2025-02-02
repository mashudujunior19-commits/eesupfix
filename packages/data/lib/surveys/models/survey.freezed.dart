// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'survey.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Survey _$SurveyFromJson(Map<String, dynamic> json) {
  return _Survey.fromJson(json);
}

/// @nodoc
mixin _$Survey {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @QuestionConverter()
  List<Question> get questions => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get wallet => throw _privateConstructorUsedError;
  @SurveyTypeConverter()
  SurveyType get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_responses')
  int? get maxResponses => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'video_url')
  String? get videoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'reward_amount')
  double? get rewardAmount => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;
  int? get points => throw _privateConstructorUsedError;
  @JsonKey(name: 'responded_at', includeToJson: false)
  DateTime? get respondedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'pass_percentage')
  double? get passPercentage => throw _privateConstructorUsedError;
  @JsonKey(name: 'enable_scoring')
  bool? get enableScoring => throw _privateConstructorUsedError;
  @JsonKey(name: 'require_all')
  bool? get requireAll => throw _privateConstructorUsedError;
  @JsonKey(name: 'enforce_time_limit')
  bool? get enforceTimeLimit => throw _privateConstructorUsedError;
  @SurveyConverter()
  @JsonKey(name: 'pre_survey')
  Survey? get preSurvey => throw _privateConstructorUsedError;
  bool? get passed => throw _privateConstructorUsedError;
  int? get score => throw _privateConstructorUsedError;

  /// Serializes this Survey to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SurveyCopyWith<Survey> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SurveyCopyWith<$Res> {
  factory $SurveyCopyWith(Survey value, $Res Function(Survey) then) =
      _$SurveyCopyWithImpl<$Res, Survey>;
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
class _$SurveyCopyWithImpl<$Res, $Val extends Survey>
    implements $SurveyCopyWith<$Res> {
  _$SurveyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      questions: null == questions
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Question>,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      wallet: freezed == wallet
          ? _value.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SurveyType,
      maxResponses: freezed == maxResponses
          ? _value.maxResponses
          : maxResponses // ignore: cast_nullable_to_non_nullable
              as int?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      rewardAmount: freezed == rewardAmount
          ? _value.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      points: freezed == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int?,
      respondedAt: freezed == respondedAt
          ? _value.respondedAt
          : respondedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      passPercentage: freezed == passPercentage
          ? _value.passPercentage
          : passPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      enableScoring: freezed == enableScoring
          ? _value.enableScoring
          : enableScoring // ignore: cast_nullable_to_non_nullable
              as bool?,
      requireAll: freezed == requireAll
          ? _value.requireAll
          : requireAll // ignore: cast_nullable_to_non_nullable
              as bool?,
      enforceTimeLimit: freezed == enforceTimeLimit
          ? _value.enforceTimeLimit
          : enforceTimeLimit // ignore: cast_nullable_to_non_nullable
              as bool?,
      preSurvey: freezed == preSurvey
          ? _value.preSurvey
          : preSurvey // ignore: cast_nullable_to_non_nullable
              as Survey?,
      passed: freezed == passed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SurveyCopyWith<$Res>? get preSurvey {
    if (_value.preSurvey == null) {
      return null;
    }

    return $SurveyCopyWith<$Res>(_value.preSurvey!, (value) {
      return _then(_value.copyWith(preSurvey: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SurveyImplCopyWith<$Res> implements $SurveyCopyWith<$Res> {
  factory _$$SurveyImplCopyWith(
          _$SurveyImpl value, $Res Function(_$SurveyImpl) then) =
      __$$SurveyImplCopyWithImpl<$Res>;
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
class __$$SurveyImplCopyWithImpl<$Res>
    extends _$SurveyCopyWithImpl<$Res, _$SurveyImpl>
    implements _$$SurveyImplCopyWith<$Res> {
  __$$SurveyImplCopyWithImpl(
      _$SurveyImpl _value, $Res Function(_$SurveyImpl) _then)
      : super(_value, _then);

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
    return _then(_$SurveyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      questions: null == questions
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Question>,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      wallet: freezed == wallet
          ? _value.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SurveyType,
      maxResponses: freezed == maxResponses
          ? _value.maxResponses
          : maxResponses // ignore: cast_nullable_to_non_nullable
              as int?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      rewardAmount: freezed == rewardAmount
          ? _value.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      points: freezed == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int?,
      respondedAt: freezed == respondedAt
          ? _value.respondedAt
          : respondedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      passPercentage: freezed == passPercentage
          ? _value.passPercentage
          : passPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      enableScoring: freezed == enableScoring
          ? _value.enableScoring
          : enableScoring // ignore: cast_nullable_to_non_nullable
              as bool?,
      requireAll: freezed == requireAll
          ? _value.requireAll
          : requireAll // ignore: cast_nullable_to_non_nullable
              as bool?,
      enforceTimeLimit: freezed == enforceTimeLimit
          ? _value.enforceTimeLimit
          : enforceTimeLimit // ignore: cast_nullable_to_non_nullable
              as bool?,
      preSurvey: freezed == preSurvey
          ? _value.preSurvey
          : preSurvey // ignore: cast_nullable_to_non_nullable
              as Survey?,
      passed: freezed == passed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SurveyImpl with DiagnosticableTreeMixin implements _Survey {
  const _$SurveyImpl(
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

  factory _$SurveyImpl.fromJson(Map<String, dynamic> json) =>
      _$$SurveyImplFromJson(json);

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

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Survey(id: $id, createdAt: $createdAt, questions: $questions, title: $title, description: $description, wallet: $wallet, type: $type, maxResponses: $maxResponses, imageUrl: $imageUrl, videoUrl: $videoUrl, rewardAmount: $rewardAmount, duration: $duration, points: $points, respondedAt: $respondedAt, passPercentage: $passPercentage, enableScoring: $enableScoring, requireAll: $requireAll, enforceTimeLimit: $enforceTimeLimit, preSurvey: $preSurvey, passed: $passed, score: $score)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
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
            other is _$SurveyImpl &&
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

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SurveyImplCopyWith<_$SurveyImpl> get copyWith =>
      __$$SurveyImplCopyWithImpl<_$SurveyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SurveyImplToJson(
      this,
    );
  }
}

abstract class _Survey implements Survey {
  const factory _Survey(
      {required final String id,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @QuestionConverter() required final List<Question> questions,
      required final String title,
      final String? description,
      final String? wallet,
      @SurveyTypeConverter() required final SurveyType type,
      @JsonKey(name: 'max_responses') final int? maxResponses,
      @JsonKey(name: 'image_url') final String? imageUrl,
      @JsonKey(name: 'video_url') final String? videoUrl,
      @JsonKey(name: 'reward_amount') final double? rewardAmount,
      final int? duration,
      final int? points,
      @JsonKey(name: 'responded_at', includeToJson: false)
      final DateTime? respondedAt,
      @JsonKey(name: 'pass_percentage') final double? passPercentage,
      @JsonKey(name: 'enable_scoring') final bool? enableScoring,
      @JsonKey(name: 'require_all') final bool? requireAll,
      @JsonKey(name: 'enforce_time_limit') final bool? enforceTimeLimit,
      @SurveyConverter() @JsonKey(name: 'pre_survey') final Survey? preSurvey,
      final bool? passed,
      final int? score}) = _$SurveyImpl;

  factory _Survey.fromJson(Map<String, dynamic> json) = _$SurveyImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @QuestionConverter()
  List<Question> get questions;
  @override
  String get title;
  @override
  String? get description;
  @override
  String? get wallet;
  @override
  @SurveyTypeConverter()
  SurveyType get type;
  @override
  @JsonKey(name: 'max_responses')
  int? get maxResponses;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(name: 'video_url')
  String? get videoUrl;
  @override
  @JsonKey(name: 'reward_amount')
  double? get rewardAmount;
  @override
  int? get duration;
  @override
  int? get points;
  @override
  @JsonKey(name: 'responded_at', includeToJson: false)
  DateTime? get respondedAt;
  @override
  @JsonKey(name: 'pass_percentage')
  double? get passPercentage;
  @override
  @JsonKey(name: 'enable_scoring')
  bool? get enableScoring;
  @override
  @JsonKey(name: 'require_all')
  bool? get requireAll;
  @override
  @JsonKey(name: 'enforce_time_limit')
  bool? get enforceTimeLimit;
  @override
  @SurveyConverter()
  @JsonKey(name: 'pre_survey')
  Survey? get preSurvey;
  @override
  bool? get passed;
  @override
  int? get score;

  /// Create a copy of Survey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SurveyImplCopyWith<_$SurveyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
