// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return _Question.fromJson(json);
}

/// @nodoc
mixin _$Question {
  @JsonKey(name: 'question_id')
  int get questionId => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  @QuestionTypeConverter()
  QuestionType get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_required')
  bool get isRequired => throw _privateConstructorUsedError;
  @JsonKey(name: 'allow_recording')
  bool? get allowRecording => throw _privateConstructorUsedError;
  @JsonKey(name: 'allow_multiple_selection')
  bool get allowMultipleSelection => throw _privateConstructorUsedError;
  @OptionConverter()
  List<Option>? get options => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'num_ratings')
  int? get numRatings => throw _privateConstructorUsedError;
  @JsonKey(name: 'slider_interval')
  int? get sliderInterval => throw _privateConstructorUsedError;
  @JsonKey(name: 'slider_max')
  int? get sliderMax => throw _privateConstructorUsedError;
  @JsonKey(name: 'slider_min')
  int? get sliderMin => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  @JsonKey(name: 'allow_multiple_files')
  bool get allowMultipleFiles => throw _privateConstructorUsedError;
  @JsonKey(name: 'media_file_type')
  String? get mediaFileType => throw _privateConstructorUsedError;

  ///answering
  @JsonKey(includeFromJson: false, includeToJson: false)
  int? get sliderValue => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  int? get ratingValue => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get openEndedAnswer => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get recordingUrl => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  File? get recordingFile => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String>? get fileUrls => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<File>? get pickedfiles => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  File? get singleFile => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get singleFileUrl => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get pickedDate => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get dateTimePicked => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get timePicked => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuestionCopyWith<Question> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionCopyWith<$Res> {
  factory $QuestionCopyWith(Question value, $Res Function(Question) then) =
      _$QuestionCopyWithImpl<$Res, Question>;
  @useResult
  $Res call(
      {@JsonKey(name: 'question_id') int questionId,
      String question,
      @QuestionTypeConverter() QuestionType type,
      @JsonKey(name: 'is_required') bool isRequired,
      @JsonKey(name: 'allow_recording') bool? allowRecording,
      @JsonKey(name: 'allow_multiple_selection') bool allowMultipleSelection,
      @OptionConverter() List<Option>? options,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'num_ratings') int? numRatings,
      @JsonKey(name: 'slider_interval') int? sliderInterval,
      @JsonKey(name: 'slider_max') int? sliderMax,
      @JsonKey(name: 'slider_min') int? sliderMin,
      String? comment,
      @JsonKey(name: 'allow_multiple_files') bool allowMultipleFiles,
      @JsonKey(name: 'media_file_type') String? mediaFileType,
      @JsonKey(includeFromJson: false, includeToJson: false) int? sliderValue,
      @JsonKey(includeFromJson: false, includeToJson: false) int? ratingValue,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? openEndedAnswer,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? recordingUrl,
      @JsonKey(includeFromJson: false, includeToJson: false)
      File? recordingFile,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<String>? fileUrls,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<File>? pickedfiles,
      @JsonKey(includeFromJson: false, includeToJson: false) File? singleFile,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? singleFileUrl,
      @JsonKey(includeFromJson: false, includeToJson: false) String? pickedDate,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? dateTimePicked,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? timePicked});
}

/// @nodoc
class _$QuestionCopyWithImpl<$Res, $Val extends Question>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? question = null,
    Object? type = null,
    Object? isRequired = null,
    Object? allowRecording = freezed,
    Object? allowMultipleSelection = null,
    Object? options = freezed,
    Object? imageUrl = freezed,
    Object? numRatings = freezed,
    Object? sliderInterval = freezed,
    Object? sliderMax = freezed,
    Object? sliderMin = freezed,
    Object? comment = freezed,
    Object? allowMultipleFiles = null,
    Object? mediaFileType = freezed,
    Object? sliderValue = freezed,
    Object? ratingValue = freezed,
    Object? openEndedAnswer = freezed,
    Object? recordingUrl = freezed,
    Object? recordingFile = freezed,
    Object? fileUrls = freezed,
    Object? pickedfiles = freezed,
    Object? singleFile = freezed,
    Object? singleFileUrl = freezed,
    Object? pickedDate = freezed,
    Object? dateTimePicked = freezed,
    Object? timePicked = freezed,
  }) {
    return _then(_value.copyWith(
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as QuestionType,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      allowRecording: freezed == allowRecording
          ? _value.allowRecording
          : allowRecording // ignore: cast_nullable_to_non_nullable
              as bool?,
      allowMultipleSelection: null == allowMultipleSelection
          ? _value.allowMultipleSelection
          : allowMultipleSelection // ignore: cast_nullable_to_non_nullable
              as bool,
      options: freezed == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<Option>?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      numRatings: freezed == numRatings
          ? _value.numRatings
          : numRatings // ignore: cast_nullable_to_non_nullable
              as int?,
      sliderInterval: freezed == sliderInterval
          ? _value.sliderInterval
          : sliderInterval // ignore: cast_nullable_to_non_nullable
              as int?,
      sliderMax: freezed == sliderMax
          ? _value.sliderMax
          : sliderMax // ignore: cast_nullable_to_non_nullable
              as int?,
      sliderMin: freezed == sliderMin
          ? _value.sliderMin
          : sliderMin // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      allowMultipleFiles: null == allowMultipleFiles
          ? _value.allowMultipleFiles
          : allowMultipleFiles // ignore: cast_nullable_to_non_nullable
              as bool,
      mediaFileType: freezed == mediaFileType
          ? _value.mediaFileType
          : mediaFileType // ignore: cast_nullable_to_non_nullable
              as String?,
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
      recordingFile: freezed == recordingFile
          ? _value.recordingFile
          : recordingFile // ignore: cast_nullable_to_non_nullable
              as File?,
      fileUrls: freezed == fileUrls
          ? _value.fileUrls
          : fileUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      pickedfiles: freezed == pickedfiles
          ? _value.pickedfiles
          : pickedfiles // ignore: cast_nullable_to_non_nullable
              as List<File>?,
      singleFile: freezed == singleFile
          ? _value.singleFile
          : singleFile // ignore: cast_nullable_to_non_nullable
              as File?,
      singleFileUrl: freezed == singleFileUrl
          ? _value.singleFileUrl
          : singleFileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      pickedDate: freezed == pickedDate
          ? _value.pickedDate
          : pickedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTimePicked: freezed == dateTimePicked
          ? _value.dateTimePicked
          : dateTimePicked // ignore: cast_nullable_to_non_nullable
              as String?,
      timePicked: freezed == timePicked
          ? _value.timePicked
          : timePicked // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuestionImplCopyWith<$Res>
    implements $QuestionCopyWith<$Res> {
  factory _$$QuestionImplCopyWith(
          _$QuestionImpl value, $Res Function(_$QuestionImpl) then) =
      __$$QuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'question_id') int questionId,
      String question,
      @QuestionTypeConverter() QuestionType type,
      @JsonKey(name: 'is_required') bool isRequired,
      @JsonKey(name: 'allow_recording') bool? allowRecording,
      @JsonKey(name: 'allow_multiple_selection') bool allowMultipleSelection,
      @OptionConverter() List<Option>? options,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'num_ratings') int? numRatings,
      @JsonKey(name: 'slider_interval') int? sliderInterval,
      @JsonKey(name: 'slider_max') int? sliderMax,
      @JsonKey(name: 'slider_min') int? sliderMin,
      String? comment,
      @JsonKey(name: 'allow_multiple_files') bool allowMultipleFiles,
      @JsonKey(name: 'media_file_type') String? mediaFileType,
      @JsonKey(includeFromJson: false, includeToJson: false) int? sliderValue,
      @JsonKey(includeFromJson: false, includeToJson: false) int? ratingValue,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? openEndedAnswer,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? recordingUrl,
      @JsonKey(includeFromJson: false, includeToJson: false)
      File? recordingFile,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<String>? fileUrls,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<File>? pickedfiles,
      @JsonKey(includeFromJson: false, includeToJson: false) File? singleFile,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? singleFileUrl,
      @JsonKey(includeFromJson: false, includeToJson: false) String? pickedDate,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? dateTimePicked,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? timePicked});
}

/// @nodoc
class __$$QuestionImplCopyWithImpl<$Res>
    extends _$QuestionCopyWithImpl<$Res, _$QuestionImpl>
    implements _$$QuestionImplCopyWith<$Res> {
  __$$QuestionImplCopyWithImpl(
      _$QuestionImpl _value, $Res Function(_$QuestionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? question = null,
    Object? type = null,
    Object? isRequired = null,
    Object? allowRecording = freezed,
    Object? allowMultipleSelection = null,
    Object? options = freezed,
    Object? imageUrl = freezed,
    Object? numRatings = freezed,
    Object? sliderInterval = freezed,
    Object? sliderMax = freezed,
    Object? sliderMin = freezed,
    Object? comment = freezed,
    Object? allowMultipleFiles = null,
    Object? mediaFileType = freezed,
    Object? sliderValue = freezed,
    Object? ratingValue = freezed,
    Object? openEndedAnswer = freezed,
    Object? recordingUrl = freezed,
    Object? recordingFile = freezed,
    Object? fileUrls = freezed,
    Object? pickedfiles = freezed,
    Object? singleFile = freezed,
    Object? singleFileUrl = freezed,
    Object? pickedDate = freezed,
    Object? dateTimePicked = freezed,
    Object? timePicked = freezed,
  }) {
    return _then(_$QuestionImpl(
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as QuestionType,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      allowRecording: freezed == allowRecording
          ? _value.allowRecording
          : allowRecording // ignore: cast_nullable_to_non_nullable
              as bool?,
      allowMultipleSelection: null == allowMultipleSelection
          ? _value.allowMultipleSelection
          : allowMultipleSelection // ignore: cast_nullable_to_non_nullable
              as bool,
      options: freezed == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<Option>?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      numRatings: freezed == numRatings
          ? _value.numRatings
          : numRatings // ignore: cast_nullable_to_non_nullable
              as int?,
      sliderInterval: freezed == sliderInterval
          ? _value.sliderInterval
          : sliderInterval // ignore: cast_nullable_to_non_nullable
              as int?,
      sliderMax: freezed == sliderMax
          ? _value.sliderMax
          : sliderMax // ignore: cast_nullable_to_non_nullable
              as int?,
      sliderMin: freezed == sliderMin
          ? _value.sliderMin
          : sliderMin // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      allowMultipleFiles: null == allowMultipleFiles
          ? _value.allowMultipleFiles
          : allowMultipleFiles // ignore: cast_nullable_to_non_nullable
              as bool,
      mediaFileType: freezed == mediaFileType
          ? _value.mediaFileType
          : mediaFileType // ignore: cast_nullable_to_non_nullable
              as String?,
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
      recordingFile: freezed == recordingFile
          ? _value.recordingFile
          : recordingFile // ignore: cast_nullable_to_non_nullable
              as File?,
      fileUrls: freezed == fileUrls
          ? _value._fileUrls
          : fileUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      pickedfiles: freezed == pickedfiles
          ? _value._pickedfiles
          : pickedfiles // ignore: cast_nullable_to_non_nullable
              as List<File>?,
      singleFile: freezed == singleFile
          ? _value.singleFile
          : singleFile // ignore: cast_nullable_to_non_nullable
              as File?,
      singleFileUrl: freezed == singleFileUrl
          ? _value.singleFileUrl
          : singleFileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      pickedDate: freezed == pickedDate
          ? _value.pickedDate
          : pickedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTimePicked: freezed == dateTimePicked
          ? _value.dateTimePicked
          : dateTimePicked // ignore: cast_nullable_to_non_nullable
              as String?,
      timePicked: freezed == timePicked
          ? _value.timePicked
          : timePicked // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionImpl with DiagnosticableTreeMixin implements _Question {
  const _$QuestionImpl(
      {@JsonKey(name: 'question_id') required this.questionId,
      required this.question,
      @QuestionTypeConverter() required this.type,
      @JsonKey(name: 'is_required') required this.isRequired,
      @JsonKey(name: 'allow_recording') this.allowRecording,
      @JsonKey(name: 'allow_multiple_selection')
      this.allowMultipleSelection = false,
      @OptionConverter() final List<Option>? options,
      @JsonKey(name: 'image_url') this.imageUrl,
      @JsonKey(name: 'num_ratings') this.numRatings,
      @JsonKey(name: 'slider_interval') this.sliderInterval,
      @JsonKey(name: 'slider_max') this.sliderMax,
      @JsonKey(name: 'slider_min') this.sliderMin,
      this.comment,
      @JsonKey(name: 'allow_multiple_files') this.allowMultipleFiles = false,
      @JsonKey(name: 'media_file_type') this.mediaFileType,
      @JsonKey(includeFromJson: false, includeToJson: false) this.sliderValue,
      @JsonKey(includeFromJson: false, includeToJson: false) this.ratingValue,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.openEndedAnswer,
      @JsonKey(includeFromJson: false, includeToJson: false) this.recordingUrl,
      @JsonKey(includeFromJson: false, includeToJson: false) this.recordingFile,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<String>? fileUrls,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<File>? pickedfiles,
      @JsonKey(includeFromJson: false, includeToJson: false) this.singleFile,
      @JsonKey(includeFromJson: false, includeToJson: false) this.singleFileUrl,
      @JsonKey(includeFromJson: false, includeToJson: false) this.pickedDate,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.dateTimePicked,
      @JsonKey(includeFromJson: false, includeToJson: false) this.timePicked})
      : _options = options,
        _fileUrls = fileUrls,
        _pickedfiles = pickedfiles;

  factory _$QuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionImplFromJson(json);

  @override
  @JsonKey(name: 'question_id')
  final int questionId;
  @override
  final String question;
  @override
  @QuestionTypeConverter()
  final QuestionType type;
  @override
  @JsonKey(name: 'is_required')
  final bool isRequired;
  @override
  @JsonKey(name: 'allow_recording')
  final bool? allowRecording;
  @override
  @JsonKey(name: 'allow_multiple_selection')
  final bool allowMultipleSelection;
  final List<Option>? _options;
  @override
  @OptionConverter()
  List<Option>? get options {
    final value = _options;
    if (value == null) return null;
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'num_ratings')
  final int? numRatings;
  @override
  @JsonKey(name: 'slider_interval')
  final int? sliderInterval;
  @override
  @JsonKey(name: 'slider_max')
  final int? sliderMax;
  @override
  @JsonKey(name: 'slider_min')
  final int? sliderMin;
  @override
  final String? comment;
  @override
  @JsonKey(name: 'allow_multiple_files')
  final bool allowMultipleFiles;
  @override
  @JsonKey(name: 'media_file_type')
  final String? mediaFileType;

  ///answering
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int? sliderValue;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int? ratingValue;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? openEndedAnswer;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? recordingUrl;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? recordingFile;
  final List<String>? _fileUrls;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String>? get fileUrls {
    final value = _fileUrls;
    if (value == null) return null;
    if (_fileUrls is EqualUnmodifiableListView) return _fileUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<File>? _pickedfiles;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<File>? get pickedfiles {
    final value = _pickedfiles;
    if (value == null) return null;
    if (_pickedfiles is EqualUnmodifiableListView) return _pickedfiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? singleFile;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? singleFileUrl;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? pickedDate;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? dateTimePicked;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? timePicked;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Question(questionId: $questionId, question: $question, type: $type, isRequired: $isRequired, allowRecording: $allowRecording, allowMultipleSelection: $allowMultipleSelection, options: $options, imageUrl: $imageUrl, numRatings: $numRatings, sliderInterval: $sliderInterval, sliderMax: $sliderMax, sliderMin: $sliderMin, comment: $comment, allowMultipleFiles: $allowMultipleFiles, mediaFileType: $mediaFileType, sliderValue: $sliderValue, ratingValue: $ratingValue, openEndedAnswer: $openEndedAnswer, recordingUrl: $recordingUrl, recordingFile: $recordingFile, fileUrls: $fileUrls, pickedfiles: $pickedfiles, singleFile: $singleFile, singleFileUrl: $singleFileUrl, pickedDate: $pickedDate, dateTimePicked: $dateTimePicked, timePicked: $timePicked)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Question'))
      ..add(DiagnosticsProperty('questionId', questionId))
      ..add(DiagnosticsProperty('question', question))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('isRequired', isRequired))
      ..add(DiagnosticsProperty('allowRecording', allowRecording))
      ..add(
          DiagnosticsProperty('allowMultipleSelection', allowMultipleSelection))
      ..add(DiagnosticsProperty('options', options))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('numRatings', numRatings))
      ..add(DiagnosticsProperty('sliderInterval', sliderInterval))
      ..add(DiagnosticsProperty('sliderMax', sliderMax))
      ..add(DiagnosticsProperty('sliderMin', sliderMin))
      ..add(DiagnosticsProperty('comment', comment))
      ..add(DiagnosticsProperty('allowMultipleFiles', allowMultipleFiles))
      ..add(DiagnosticsProperty('mediaFileType', mediaFileType))
      ..add(DiagnosticsProperty('sliderValue', sliderValue))
      ..add(DiagnosticsProperty('ratingValue', ratingValue))
      ..add(DiagnosticsProperty('openEndedAnswer', openEndedAnswer))
      ..add(DiagnosticsProperty('recordingUrl', recordingUrl))
      ..add(DiagnosticsProperty('recordingFile', recordingFile))
      ..add(DiagnosticsProperty('fileUrls', fileUrls))
      ..add(DiagnosticsProperty('pickedfiles', pickedfiles))
      ..add(DiagnosticsProperty('singleFile', singleFile))
      ..add(DiagnosticsProperty('singleFileUrl', singleFileUrl))
      ..add(DiagnosticsProperty('pickedDate', pickedDate))
      ..add(DiagnosticsProperty('dateTimePicked', dateTimePicked))
      ..add(DiagnosticsProperty('timePicked', timePicked));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionImpl &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            (identical(other.allowRecording, allowRecording) ||
                other.allowRecording == allowRecording) &&
            (identical(other.allowMultipleSelection, allowMultipleSelection) ||
                other.allowMultipleSelection == allowMultipleSelection) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.numRatings, numRatings) ||
                other.numRatings == numRatings) &&
            (identical(other.sliderInterval, sliderInterval) ||
                other.sliderInterval == sliderInterval) &&
            (identical(other.sliderMax, sliderMax) ||
                other.sliderMax == sliderMax) &&
            (identical(other.sliderMin, sliderMin) ||
                other.sliderMin == sliderMin) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.allowMultipleFiles, allowMultipleFiles) ||
                other.allowMultipleFiles == allowMultipleFiles) &&
            (identical(other.mediaFileType, mediaFileType) ||
                other.mediaFileType == mediaFileType) &&
            (identical(other.sliderValue, sliderValue) ||
                other.sliderValue == sliderValue) &&
            (identical(other.ratingValue, ratingValue) ||
                other.ratingValue == ratingValue) &&
            (identical(other.openEndedAnswer, openEndedAnswer) ||
                other.openEndedAnswer == openEndedAnswer) &&
            (identical(other.recordingUrl, recordingUrl) ||
                other.recordingUrl == recordingUrl) &&
            (identical(other.recordingFile, recordingFile) ||
                other.recordingFile == recordingFile) &&
            const DeepCollectionEquality().equals(other._fileUrls, _fileUrls) &&
            const DeepCollectionEquality()
                .equals(other._pickedfiles, _pickedfiles) &&
            (identical(other.singleFile, singleFile) ||
                other.singleFile == singleFile) &&
            (identical(other.singleFileUrl, singleFileUrl) ||
                other.singleFileUrl == singleFileUrl) &&
            (identical(other.pickedDate, pickedDate) ||
                other.pickedDate == pickedDate) &&
            (identical(other.dateTimePicked, dateTimePicked) ||
                other.dateTimePicked == dateTimePicked) &&
            (identical(other.timePicked, timePicked) ||
                other.timePicked == timePicked));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        questionId,
        question,
        type,
        isRequired,
        allowRecording,
        allowMultipleSelection,
        const DeepCollectionEquality().hash(_options),
        imageUrl,
        numRatings,
        sliderInterval,
        sliderMax,
        sliderMin,
        comment,
        allowMultipleFiles,
        mediaFileType,
        sliderValue,
        ratingValue,
        openEndedAnswer,
        recordingUrl,
        recordingFile,
        const DeepCollectionEquality().hash(_fileUrls),
        const DeepCollectionEquality().hash(_pickedfiles),
        singleFile,
        singleFileUrl,
        pickedDate,
        dateTimePicked,
        timePicked
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionImplCopyWith<_$QuestionImpl> get copyWith =>
      __$$QuestionImplCopyWithImpl<_$QuestionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionImplToJson(
      this,
    );
  }
}

abstract class _Question implements Question {
  const factory _Question(
      {@JsonKey(name: 'question_id') required final int questionId,
      required final String question,
      @QuestionTypeConverter() required final QuestionType type,
      @JsonKey(name: 'is_required') required final bool isRequired,
      @JsonKey(name: 'allow_recording') final bool? allowRecording,
      @JsonKey(name: 'allow_multiple_selection')
      final bool allowMultipleSelection,
      @OptionConverter() final List<Option>? options,
      @JsonKey(name: 'image_url') final String? imageUrl,
      @JsonKey(name: 'num_ratings') final int? numRatings,
      @JsonKey(name: 'slider_interval') final int? sliderInterval,
      @JsonKey(name: 'slider_max') final int? sliderMax,
      @JsonKey(name: 'slider_min') final int? sliderMin,
      final String? comment,
      @JsonKey(name: 'allow_multiple_files') final bool allowMultipleFiles,
      @JsonKey(name: 'media_file_type') final String? mediaFileType,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final int? sliderValue,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final int? ratingValue,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final String? openEndedAnswer,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final String? recordingUrl,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final File? recordingFile,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<String>? fileUrls,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<File>? pickedfiles,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final File? singleFile,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final String? singleFileUrl,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final String? pickedDate,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final String? dateTimePicked,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final String? timePicked}) = _$QuestionImpl;

  factory _Question.fromJson(Map<String, dynamic> json) =
      _$QuestionImpl.fromJson;

  @override
  @JsonKey(name: 'question_id')
  int get questionId;
  @override
  String get question;
  @override
  @QuestionTypeConverter()
  QuestionType get type;
  @override
  @JsonKey(name: 'is_required')
  bool get isRequired;
  @override
  @JsonKey(name: 'allow_recording')
  bool? get allowRecording;
  @override
  @JsonKey(name: 'allow_multiple_selection')
  bool get allowMultipleSelection;
  @override
  @OptionConverter()
  List<Option>? get options;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(name: 'num_ratings')
  int? get numRatings;
  @override
  @JsonKey(name: 'slider_interval')
  int? get sliderInterval;
  @override
  @JsonKey(name: 'slider_max')
  int? get sliderMax;
  @override
  @JsonKey(name: 'slider_min')
  int? get sliderMin;
  @override
  String? get comment;
  @override
  @JsonKey(name: 'allow_multiple_files')
  bool get allowMultipleFiles;
  @override
  @JsonKey(name: 'media_file_type')
  String? get mediaFileType;
  @override

  ///answering
  @JsonKey(includeFromJson: false, includeToJson: false)
  int? get sliderValue;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  int? get ratingValue;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get openEndedAnswer;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get recordingUrl;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  File? get recordingFile;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String>? get fileUrls;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<File>? get pickedfiles;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  File? get singleFile;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get singleFileUrl;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get pickedDate;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get dateTimePicked;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get timePicked;
  @override
  @JsonKey(ignore: true)
  _$$QuestionImplCopyWith<_$QuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
