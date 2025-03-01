// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Question implements DiagnosticableTreeMixin {
  @JsonKey(name: 'question_id')
  int get questionId;
  String get question;
  @QuestionTypeConverter()
  QuestionType get type;
  @JsonKey(name: 'is_required')
  bool get isRequired;
  @JsonKey(name: 'allow_recording')
  bool? get allowRecording;
  @JsonKey(name: 'allow_multiple_selection')
  bool get allowMultipleSelection;
  @ChoiceConverter()
  @JsonKey(name: 'options')
  List<Choice>? get choices;
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @JsonKey(name: 'num_ratings')
  int? get numRatings;
  @JsonKey(name: 'slider_interval')
  int? get sliderInterval;
  @JsonKey(name: 'slider_max')
  int? get sliderMax;
  @JsonKey(name: 'slider_min')
  int? get sliderMin;
  String? get comment;
  @JsonKey(name: 'allow_multiple_files')
  bool get allowMultipleFiles;
  @JsonKey(name: 'media_file_type')
  String? get mediaFileType;

  ///answering
  @JsonKey(includeFromJson: false, includeToJson: false)
  int? get sliderValue;
  @JsonKey(includeFromJson: false, includeToJson: false)
  int? get ratingValue;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get openEndedAnswer;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get recordingUrl;
  @JsonKey(includeFromJson: false, includeToJson: false)
  File? get recordingFile;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String>? get fileUrls;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<File>? get pickedfiles;
  @JsonKey(includeFromJson: false, includeToJson: false)
  File? get singleFile;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get singleFileUrl;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get pickedDate;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get dateTimePicked;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get timePicked;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuestionCopyWith<Question> get copyWith =>
      _$QuestionCopyWithImpl<Question>(this as Question, _$identity);

  /// Serializes this Question to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'Question'))
      ..add(DiagnosticsProperty('questionId', questionId))
      ..add(DiagnosticsProperty('question', question))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('isRequired', isRequired))
      ..add(DiagnosticsProperty('allowRecording', allowRecording))
      ..add(
          DiagnosticsProperty('allowMultipleSelection', allowMultipleSelection))
      ..add(DiagnosticsProperty('choices', choices))
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
            other is Question &&
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
            const DeepCollectionEquality().equals(other.choices, choices) &&
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
            const DeepCollectionEquality().equals(other.fileUrls, fileUrls) &&
            const DeepCollectionEquality()
                .equals(other.pickedfiles, pickedfiles) &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        questionId,
        question,
        type,
        isRequired,
        allowRecording,
        allowMultipleSelection,
        const DeepCollectionEquality().hash(choices),
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
        const DeepCollectionEquality().hash(fileUrls),
        const DeepCollectionEquality().hash(pickedfiles),
        singleFile,
        singleFileUrl,
        pickedDate,
        dateTimePicked,
        timePicked
      ]);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Question(questionId: $questionId, question: $question, type: $type, isRequired: $isRequired, allowRecording: $allowRecording, allowMultipleSelection: $allowMultipleSelection, choices: $choices, imageUrl: $imageUrl, numRatings: $numRatings, sliderInterval: $sliderInterval, sliderMax: $sliderMax, sliderMin: $sliderMin, comment: $comment, allowMultipleFiles: $allowMultipleFiles, mediaFileType: $mediaFileType, sliderValue: $sliderValue, ratingValue: $ratingValue, openEndedAnswer: $openEndedAnswer, recordingUrl: $recordingUrl, recordingFile: $recordingFile, fileUrls: $fileUrls, pickedfiles: $pickedfiles, singleFile: $singleFile, singleFileUrl: $singleFileUrl, pickedDate: $pickedDate, dateTimePicked: $dateTimePicked, timePicked: $timePicked)';
  }
}

/// @nodoc
abstract mixin class $QuestionCopyWith<$Res> {
  factory $QuestionCopyWith(Question value, $Res Function(Question) _then) =
      _$QuestionCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'question_id') int questionId,
      String question,
      @QuestionTypeConverter() QuestionType type,
      @JsonKey(name: 'is_required') bool isRequired,
      @JsonKey(name: 'allow_recording') bool? allowRecording,
      @JsonKey(name: 'allow_multiple_selection') bool allowMultipleSelection,
      @ChoiceConverter() @JsonKey(name: 'options') List<Choice>? choices,
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
class _$QuestionCopyWithImpl<$Res> implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._self, this._then);

  final Question _self;
  final $Res Function(Question) _then;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? question = null,
    Object? type = null,
    Object? isRequired = null,
    Object? allowRecording = freezed,
    Object? allowMultipleSelection = null,
    Object? choices = freezed,
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
    return _then(_self.copyWith(
      questionId: null == questionId
          ? _self.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
      question: null == question
          ? _self.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as QuestionType,
      isRequired: null == isRequired
          ? _self.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      allowRecording: freezed == allowRecording
          ? _self.allowRecording
          : allowRecording // ignore: cast_nullable_to_non_nullable
              as bool?,
      allowMultipleSelection: null == allowMultipleSelection
          ? _self.allowMultipleSelection
          : allowMultipleSelection // ignore: cast_nullable_to_non_nullable
              as bool,
      choices: freezed == choices
          ? _self.choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<Choice>?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      numRatings: freezed == numRatings
          ? _self.numRatings
          : numRatings // ignore: cast_nullable_to_non_nullable
              as int?,
      sliderInterval: freezed == sliderInterval
          ? _self.sliderInterval
          : sliderInterval // ignore: cast_nullable_to_non_nullable
              as int?,
      sliderMax: freezed == sliderMax
          ? _self.sliderMax
          : sliderMax // ignore: cast_nullable_to_non_nullable
              as int?,
      sliderMin: freezed == sliderMin
          ? _self.sliderMin
          : sliderMin // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: freezed == comment
          ? _self.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      allowMultipleFiles: null == allowMultipleFiles
          ? _self.allowMultipleFiles
          : allowMultipleFiles // ignore: cast_nullable_to_non_nullable
              as bool,
      mediaFileType: freezed == mediaFileType
          ? _self.mediaFileType
          : mediaFileType // ignore: cast_nullable_to_non_nullable
              as String?,
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
      recordingFile: freezed == recordingFile
          ? _self.recordingFile
          : recordingFile // ignore: cast_nullable_to_non_nullable
              as File?,
      fileUrls: freezed == fileUrls
          ? _self.fileUrls
          : fileUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      pickedfiles: freezed == pickedfiles
          ? _self.pickedfiles
          : pickedfiles // ignore: cast_nullable_to_non_nullable
              as List<File>?,
      singleFile: freezed == singleFile
          ? _self.singleFile
          : singleFile // ignore: cast_nullable_to_non_nullable
              as File?,
      singleFileUrl: freezed == singleFileUrl
          ? _self.singleFileUrl
          : singleFileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      pickedDate: freezed == pickedDate
          ? _self.pickedDate
          : pickedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTimePicked: freezed == dateTimePicked
          ? _self.dateTimePicked
          : dateTimePicked // ignore: cast_nullable_to_non_nullable
              as String?,
      timePicked: freezed == timePicked
          ? _self.timePicked
          : timePicked // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Question with DiagnosticableTreeMixin implements Question {
  const _Question(
      {@JsonKey(name: 'question_id') required this.questionId,
      required this.question,
      @QuestionTypeConverter() required this.type,
      @JsonKey(name: 'is_required') required this.isRequired,
      @JsonKey(name: 'allow_recording') this.allowRecording,
      @JsonKey(name: 'allow_multiple_selection')
      this.allowMultipleSelection = false,
      @ChoiceConverter() @JsonKey(name: 'options') final List<Choice>? choices,
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
      : _choices = choices,
        _fileUrls = fileUrls,
        _pickedfiles = pickedfiles;
  factory _Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

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
  final List<Choice>? _choices;
  @override
  @ChoiceConverter()
  @JsonKey(name: 'options')
  List<Choice>? get choices {
    final value = _choices;
    if (value == null) return null;
    if (_choices is EqualUnmodifiableListView) return _choices;
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

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuestionCopyWith<_Question> get copyWith =>
      __$QuestionCopyWithImpl<_Question>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QuestionToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'Question'))
      ..add(DiagnosticsProperty('questionId', questionId))
      ..add(DiagnosticsProperty('question', question))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('isRequired', isRequired))
      ..add(DiagnosticsProperty('allowRecording', allowRecording))
      ..add(
          DiagnosticsProperty('allowMultipleSelection', allowMultipleSelection))
      ..add(DiagnosticsProperty('choices', choices))
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
            other is _Question &&
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
            const DeepCollectionEquality().equals(other._choices, _choices) &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        questionId,
        question,
        type,
        isRequired,
        allowRecording,
        allowMultipleSelection,
        const DeepCollectionEquality().hash(_choices),
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

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Question(questionId: $questionId, question: $question, type: $type, isRequired: $isRequired, allowRecording: $allowRecording, allowMultipleSelection: $allowMultipleSelection, choices: $choices, imageUrl: $imageUrl, numRatings: $numRatings, sliderInterval: $sliderInterval, sliderMax: $sliderMax, sliderMin: $sliderMin, comment: $comment, allowMultipleFiles: $allowMultipleFiles, mediaFileType: $mediaFileType, sliderValue: $sliderValue, ratingValue: $ratingValue, openEndedAnswer: $openEndedAnswer, recordingUrl: $recordingUrl, recordingFile: $recordingFile, fileUrls: $fileUrls, pickedfiles: $pickedfiles, singleFile: $singleFile, singleFileUrl: $singleFileUrl, pickedDate: $pickedDate, dateTimePicked: $dateTimePicked, timePicked: $timePicked)';
  }
}

/// @nodoc
abstract mixin class _$QuestionCopyWith<$Res>
    implements $QuestionCopyWith<$Res> {
  factory _$QuestionCopyWith(_Question value, $Res Function(_Question) _then) =
      __$QuestionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'question_id') int questionId,
      String question,
      @QuestionTypeConverter() QuestionType type,
      @JsonKey(name: 'is_required') bool isRequired,
      @JsonKey(name: 'allow_recording') bool? allowRecording,
      @JsonKey(name: 'allow_multiple_selection') bool allowMultipleSelection,
      @ChoiceConverter() @JsonKey(name: 'options') List<Choice>? choices,
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
class __$QuestionCopyWithImpl<$Res> implements _$QuestionCopyWith<$Res> {
  __$QuestionCopyWithImpl(this._self, this._then);

  final _Question _self;
  final $Res Function(_Question) _then;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? questionId = null,
    Object? question = null,
    Object? type = null,
    Object? isRequired = null,
    Object? allowRecording = freezed,
    Object? allowMultipleSelection = null,
    Object? choices = freezed,
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
    return _then(_Question(
      questionId: null == questionId
          ? _self.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
      question: null == question
          ? _self.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as QuestionType,
      isRequired: null == isRequired
          ? _self.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      allowRecording: freezed == allowRecording
          ? _self.allowRecording
          : allowRecording // ignore: cast_nullable_to_non_nullable
              as bool?,
      allowMultipleSelection: null == allowMultipleSelection
          ? _self.allowMultipleSelection
          : allowMultipleSelection // ignore: cast_nullable_to_non_nullable
              as bool,
      choices: freezed == choices
          ? _self._choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<Choice>?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      numRatings: freezed == numRatings
          ? _self.numRatings
          : numRatings // ignore: cast_nullable_to_non_nullable
              as int?,
      sliderInterval: freezed == sliderInterval
          ? _self.sliderInterval
          : sliderInterval // ignore: cast_nullable_to_non_nullable
              as int?,
      sliderMax: freezed == sliderMax
          ? _self.sliderMax
          : sliderMax // ignore: cast_nullable_to_non_nullable
              as int?,
      sliderMin: freezed == sliderMin
          ? _self.sliderMin
          : sliderMin // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: freezed == comment
          ? _self.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      allowMultipleFiles: null == allowMultipleFiles
          ? _self.allowMultipleFiles
          : allowMultipleFiles // ignore: cast_nullable_to_non_nullable
              as bool,
      mediaFileType: freezed == mediaFileType
          ? _self.mediaFileType
          : mediaFileType // ignore: cast_nullable_to_non_nullable
              as String?,
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
      recordingFile: freezed == recordingFile
          ? _self.recordingFile
          : recordingFile // ignore: cast_nullable_to_non_nullable
              as File?,
      fileUrls: freezed == fileUrls
          ? _self._fileUrls
          : fileUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      pickedfiles: freezed == pickedfiles
          ? _self._pickedfiles
          : pickedfiles // ignore: cast_nullable_to_non_nullable
              as List<File>?,
      singleFile: freezed == singleFile
          ? _self.singleFile
          : singleFile // ignore: cast_nullable_to_non_nullable
              as File?,
      singleFileUrl: freezed == singleFileUrl
          ? _self.singleFileUrl
          : singleFileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      pickedDate: freezed == pickedDate
          ? _self.pickedDate
          : pickedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTimePicked: freezed == dateTimePicked
          ? _self.dateTimePicked
          : dateTimePicked // ignore: cast_nullable_to_non_nullable
              as String?,
      timePicked: freezed == timePicked
          ? _self.timePicked
          : timePicked // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
