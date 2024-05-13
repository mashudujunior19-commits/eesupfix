// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eesupool_issue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EESUpoolIssue _$EESUpoolIssueFromJson(Map<String, dynamic> json) {
  return _EESUpoolIssue.fromJson(json);
}

/// @nodoc
mixin _$EESUpoolIssue {
  @JsonKey(includeToJson: false, name: 'issue_id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'eesupool_id')
  int get eesupoolId => throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_pool_id')
  int? get parentPoolId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'reporter_id')
  String? get reporterId => throw _privateConstructorUsedError;
  @JsonKey(name: 'offender_id')
  String? get offenderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'resolved_at')
  DateTime? get resolvedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'message_id')
  int? get chatMessageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'attachments')
  @MediaFileConverter()
  List<MediaFile>? get attachments => throw _privateConstructorUsedError;
  @ChatMessageConverter()
  @JsonKey(name: 'message', includeToJson: false)
  ChatMessage? get chatMessage => throw _privateConstructorUsedError;
  @EESUpoolMemberConverter()
  @JsonKey(name: 'reporter_member', includeToJson: false)
  EESUpoolMember? get reporter => throw _privateConstructorUsedError;
  @EESUpoolMemberConverter()
  @JsonKey(name: 'offender_member', includeToJson: false)
  EESUpoolMember? get offender => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EESUpoolIssueCopyWith<EESUpoolIssue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EESUpoolIssueCopyWith<$Res> {
  factory $EESUpoolIssueCopyWith(
          EESUpoolIssue value, $Res Function(EESUpoolIssue) then) =
      _$EESUpoolIssueCopyWithImpl<$Res, EESUpoolIssue>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false, name: 'issue_id') String id,
      @JsonKey(name: 'eesupool_id') int eesupoolId,
      @JsonKey(name: 'parent_pool_id') int? parentPoolId,
      @JsonKey(name: 'created_at', includeToJson: false) DateTime createdAt,
      @JsonKey(name: 'reporter_id') String? reporterId,
      @JsonKey(name: 'offender_id') String? offenderId,
      @JsonKey(name: 'description') String description,
      @JsonKey(name: 'resolved_at') DateTime? resolvedAt,
      @JsonKey(name: 'message_id') int? chatMessageId,
      @JsonKey(name: 'attachments')
      @MediaFileConverter()
      List<MediaFile>? attachments,
      @ChatMessageConverter()
      @JsonKey(name: 'message', includeToJson: false)
      ChatMessage? chatMessage,
      @EESUpoolMemberConverter()
      @JsonKey(name: 'reporter_member', includeToJson: false)
      EESUpoolMember? reporter,
      @EESUpoolMemberConverter()
      @JsonKey(name: 'offender_member', includeToJson: false)
      EESUpoolMember? offender});

  $ChatMessageCopyWith<$Res>? get chatMessage;
  $EESUpoolMemberCopyWith<$Res>? get reporter;
  $EESUpoolMemberCopyWith<$Res>? get offender;
}

/// @nodoc
class _$EESUpoolIssueCopyWithImpl<$Res, $Val extends EESUpoolIssue>
    implements $EESUpoolIssueCopyWith<$Res> {
  _$EESUpoolIssueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eesupoolId = null,
    Object? parentPoolId = freezed,
    Object? createdAt = null,
    Object? reporterId = freezed,
    Object? offenderId = freezed,
    Object? description = null,
    Object? resolvedAt = freezed,
    Object? chatMessageId = freezed,
    Object? attachments = freezed,
    Object? chatMessage = freezed,
    Object? reporter = freezed,
    Object? offender = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eesupoolId: null == eesupoolId
          ? _value.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      parentPoolId: freezed == parentPoolId
          ? _value.parentPoolId
          : parentPoolId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reporterId: freezed == reporterId
          ? _value.reporterId
          : reporterId // ignore: cast_nullable_to_non_nullable
              as String?,
      offenderId: freezed == offenderId
          ? _value.offenderId
          : offenderId // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      chatMessageId: freezed == chatMessageId
          ? _value.chatMessageId
          : chatMessageId // ignore: cast_nullable_to_non_nullable
              as int?,
      attachments: freezed == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<MediaFile>?,
      chatMessage: freezed == chatMessage
          ? _value.chatMessage
          : chatMessage // ignore: cast_nullable_to_non_nullable
              as ChatMessage?,
      reporter: freezed == reporter
          ? _value.reporter
          : reporter // ignore: cast_nullable_to_non_nullable
              as EESUpoolMember?,
      offender: freezed == offender
          ? _value.offender
          : offender // ignore: cast_nullable_to_non_nullable
              as EESUpoolMember?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatMessageCopyWith<$Res>? get chatMessage {
    if (_value.chatMessage == null) {
      return null;
    }

    return $ChatMessageCopyWith<$Res>(_value.chatMessage!, (value) {
      return _then(_value.copyWith(chatMessage: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EESUpoolMemberCopyWith<$Res>? get reporter {
    if (_value.reporter == null) {
      return null;
    }

    return $EESUpoolMemberCopyWith<$Res>(_value.reporter!, (value) {
      return _then(_value.copyWith(reporter: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EESUpoolMemberCopyWith<$Res>? get offender {
    if (_value.offender == null) {
      return null;
    }

    return $EESUpoolMemberCopyWith<$Res>(_value.offender!, (value) {
      return _then(_value.copyWith(offender: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EESUpoolIssueImplCopyWith<$Res>
    implements $EESUpoolIssueCopyWith<$Res> {
  factory _$$EESUpoolIssueImplCopyWith(
          _$EESUpoolIssueImpl value, $Res Function(_$EESUpoolIssueImpl) then) =
      __$$EESUpoolIssueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false, name: 'issue_id') String id,
      @JsonKey(name: 'eesupool_id') int eesupoolId,
      @JsonKey(name: 'parent_pool_id') int? parentPoolId,
      @JsonKey(name: 'created_at', includeToJson: false) DateTime createdAt,
      @JsonKey(name: 'reporter_id') String? reporterId,
      @JsonKey(name: 'offender_id') String? offenderId,
      @JsonKey(name: 'description') String description,
      @JsonKey(name: 'resolved_at') DateTime? resolvedAt,
      @JsonKey(name: 'message_id') int? chatMessageId,
      @JsonKey(name: 'attachments')
      @MediaFileConverter()
      List<MediaFile>? attachments,
      @ChatMessageConverter()
      @JsonKey(name: 'message', includeToJson: false)
      ChatMessage? chatMessage,
      @EESUpoolMemberConverter()
      @JsonKey(name: 'reporter_member', includeToJson: false)
      EESUpoolMember? reporter,
      @EESUpoolMemberConverter()
      @JsonKey(name: 'offender_member', includeToJson: false)
      EESUpoolMember? offender});

  @override
  $ChatMessageCopyWith<$Res>? get chatMessage;
  @override
  $EESUpoolMemberCopyWith<$Res>? get reporter;
  @override
  $EESUpoolMemberCopyWith<$Res>? get offender;
}

/// @nodoc
class __$$EESUpoolIssueImplCopyWithImpl<$Res>
    extends _$EESUpoolIssueCopyWithImpl<$Res, _$EESUpoolIssueImpl>
    implements _$$EESUpoolIssueImplCopyWith<$Res> {
  __$$EESUpoolIssueImplCopyWithImpl(
      _$EESUpoolIssueImpl _value, $Res Function(_$EESUpoolIssueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eesupoolId = null,
    Object? parentPoolId = freezed,
    Object? createdAt = null,
    Object? reporterId = freezed,
    Object? offenderId = freezed,
    Object? description = null,
    Object? resolvedAt = freezed,
    Object? chatMessageId = freezed,
    Object? attachments = freezed,
    Object? chatMessage = freezed,
    Object? reporter = freezed,
    Object? offender = freezed,
  }) {
    return _then(_$EESUpoolIssueImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eesupoolId: null == eesupoolId
          ? _value.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      parentPoolId: freezed == parentPoolId
          ? _value.parentPoolId
          : parentPoolId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reporterId: freezed == reporterId
          ? _value.reporterId
          : reporterId // ignore: cast_nullable_to_non_nullable
              as String?,
      offenderId: freezed == offenderId
          ? _value.offenderId
          : offenderId // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      chatMessageId: freezed == chatMessageId
          ? _value.chatMessageId
          : chatMessageId // ignore: cast_nullable_to_non_nullable
              as int?,
      attachments: freezed == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<MediaFile>?,
      chatMessage: freezed == chatMessage
          ? _value.chatMessage
          : chatMessage // ignore: cast_nullable_to_non_nullable
              as ChatMessage?,
      reporter: freezed == reporter
          ? _value.reporter
          : reporter // ignore: cast_nullable_to_non_nullable
              as EESUpoolMember?,
      offender: freezed == offender
          ? _value.offender
          : offender // ignore: cast_nullable_to_non_nullable
              as EESUpoolMember?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EESUpoolIssueImpl
    with DiagnosticableTreeMixin
    implements _EESUpoolIssue {
  const _$EESUpoolIssueImpl(
      {@JsonKey(includeToJson: false, name: 'issue_id') required this.id,
      @JsonKey(name: 'eesupool_id') required this.eesupoolId,
      @JsonKey(name: 'parent_pool_id') this.parentPoolId,
      @JsonKey(name: 'created_at', includeToJson: false)
      required this.createdAt,
      @JsonKey(name: 'reporter_id') this.reporterId,
      @JsonKey(name: 'offender_id') this.offenderId,
      @JsonKey(name: 'description') required this.description,
      @JsonKey(name: 'resolved_at') this.resolvedAt,
      @JsonKey(name: 'message_id') this.chatMessageId,
      @JsonKey(name: 'attachments')
      @MediaFileConverter()
      final List<MediaFile>? attachments,
      @ChatMessageConverter()
      @JsonKey(name: 'message', includeToJson: false)
      this.chatMessage,
      @EESUpoolMemberConverter()
      @JsonKey(name: 'reporter_member', includeToJson: false)
      this.reporter,
      @EESUpoolMemberConverter()
      @JsonKey(name: 'offender_member', includeToJson: false)
      this.offender})
      : _attachments = attachments;

  factory _$EESUpoolIssueImpl.fromJson(Map<String, dynamic> json) =>
      _$$EESUpoolIssueImplFromJson(json);

  @override
  @JsonKey(includeToJson: false, name: 'issue_id')
  final String id;
  @override
  @JsonKey(name: 'eesupool_id')
  final int eesupoolId;
  @override
  @JsonKey(name: 'parent_pool_id')
  final int? parentPoolId;
  @override
  @JsonKey(name: 'created_at', includeToJson: false)
  final DateTime createdAt;
  @override
  @JsonKey(name: 'reporter_id')
  final String? reporterId;
  @override
  @JsonKey(name: 'offender_id')
  final String? offenderId;
  @override
  @JsonKey(name: 'description')
  final String description;
  @override
  @JsonKey(name: 'resolved_at')
  final DateTime? resolvedAt;
  @override
  @JsonKey(name: 'message_id')
  final int? chatMessageId;
  final List<MediaFile>? _attachments;
  @override
  @JsonKey(name: 'attachments')
  @MediaFileConverter()
  List<MediaFile>? get attachments {
    final value = _attachments;
    if (value == null) return null;
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @ChatMessageConverter()
  @JsonKey(name: 'message', includeToJson: false)
  final ChatMessage? chatMessage;
  @override
  @EESUpoolMemberConverter()
  @JsonKey(name: 'reporter_member', includeToJson: false)
  final EESUpoolMember? reporter;
  @override
  @EESUpoolMemberConverter()
  @JsonKey(name: 'offender_member', includeToJson: false)
  final EESUpoolMember? offender;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EESUpoolIssue(id: $id, eesupoolId: $eesupoolId, parentPoolId: $parentPoolId, createdAt: $createdAt, reporterId: $reporterId, offenderId: $offenderId, description: $description, resolvedAt: $resolvedAt, chatMessageId: $chatMessageId, attachments: $attachments, chatMessage: $chatMessage, reporter: $reporter, offender: $offender)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EESUpoolIssue'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('eesupoolId', eesupoolId))
      ..add(DiagnosticsProperty('parentPoolId', parentPoolId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('reporterId', reporterId))
      ..add(DiagnosticsProperty('offenderId', offenderId))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('resolvedAt', resolvedAt))
      ..add(DiagnosticsProperty('chatMessageId', chatMessageId))
      ..add(DiagnosticsProperty('attachments', attachments))
      ..add(DiagnosticsProperty('chatMessage', chatMessage))
      ..add(DiagnosticsProperty('reporter', reporter))
      ..add(DiagnosticsProperty('offender', offender));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EESUpoolIssueImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eesupoolId, eesupoolId) ||
                other.eesupoolId == eesupoolId) &&
            (identical(other.parentPoolId, parentPoolId) ||
                other.parentPoolId == parentPoolId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.reporterId, reporterId) ||
                other.reporterId == reporterId) &&
            (identical(other.offenderId, offenderId) ||
                other.offenderId == offenderId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt) &&
            (identical(other.chatMessageId, chatMessageId) ||
                other.chatMessageId == chatMessageId) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            (identical(other.chatMessage, chatMessage) ||
                other.chatMessage == chatMessage) &&
            (identical(other.reporter, reporter) ||
                other.reporter == reporter) &&
            (identical(other.offender, offender) ||
                other.offender == offender));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      eesupoolId,
      parentPoolId,
      createdAt,
      reporterId,
      offenderId,
      description,
      resolvedAt,
      chatMessageId,
      const DeepCollectionEquality().hash(_attachments),
      chatMessage,
      reporter,
      offender);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EESUpoolIssueImplCopyWith<_$EESUpoolIssueImpl> get copyWith =>
      __$$EESUpoolIssueImplCopyWithImpl<_$EESUpoolIssueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EESUpoolIssueImplToJson(
      this,
    );
  }
}

abstract class _EESUpoolIssue implements EESUpoolIssue {
  const factory _EESUpoolIssue(
      {@JsonKey(includeToJson: false, name: 'issue_id')
      required final String id,
      @JsonKey(name: 'eesupool_id') required final int eesupoolId,
      @JsonKey(name: 'parent_pool_id') final int? parentPoolId,
      @JsonKey(name: 'created_at', includeToJson: false)
      required final DateTime createdAt,
      @JsonKey(name: 'reporter_id') final String? reporterId,
      @JsonKey(name: 'offender_id') final String? offenderId,
      @JsonKey(name: 'description') required final String description,
      @JsonKey(name: 'resolved_at') final DateTime? resolvedAt,
      @JsonKey(name: 'message_id') final int? chatMessageId,
      @JsonKey(name: 'attachments')
      @MediaFileConverter()
      final List<MediaFile>? attachments,
      @ChatMessageConverter()
      @JsonKey(name: 'message', includeToJson: false)
      final ChatMessage? chatMessage,
      @EESUpoolMemberConverter()
      @JsonKey(name: 'reporter_member', includeToJson: false)
      final EESUpoolMember? reporter,
      @EESUpoolMemberConverter()
      @JsonKey(name: 'offender_member', includeToJson: false)
      final EESUpoolMember? offender}) = _$EESUpoolIssueImpl;

  factory _EESUpoolIssue.fromJson(Map<String, dynamic> json) =
      _$EESUpoolIssueImpl.fromJson;

  @override
  @JsonKey(includeToJson: false, name: 'issue_id')
  String get id;
  @override
  @JsonKey(name: 'eesupool_id')
  int get eesupoolId;
  @override
  @JsonKey(name: 'parent_pool_id')
  int? get parentPoolId;
  @override
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime get createdAt;
  @override
  @JsonKey(name: 'reporter_id')
  String? get reporterId;
  @override
  @JsonKey(name: 'offender_id')
  String? get offenderId;
  @override
  @JsonKey(name: 'description')
  String get description;
  @override
  @JsonKey(name: 'resolved_at')
  DateTime? get resolvedAt;
  @override
  @JsonKey(name: 'message_id')
  int? get chatMessageId;
  @override
  @JsonKey(name: 'attachments')
  @MediaFileConverter()
  List<MediaFile>? get attachments;
  @override
  @ChatMessageConverter()
  @JsonKey(name: 'message', includeToJson: false)
  ChatMessage? get chatMessage;
  @override
  @EESUpoolMemberConverter()
  @JsonKey(name: 'reporter_member', includeToJson: false)
  EESUpoolMember? get reporter;
  @override
  @EESUpoolMemberConverter()
  @JsonKey(name: 'offender_member', includeToJson: false)
  EESUpoolMember? get offender;
  @override
  @JsonKey(ignore: true)
  _$$EESUpoolIssueImplCopyWith<_$EESUpoolIssueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
