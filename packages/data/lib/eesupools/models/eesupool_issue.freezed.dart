// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eesupool_issue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EESUpoolIssue implements DiagnosticableTreeMixin {
  @JsonKey(includeToJson: false, name: 'issue_id')
  String get id;
  @JsonKey(name: 'eesupool_id')
  int get eesupoolId;
  @JsonKey(name: 'parent_pool_id')
  int? get parentPoolId;
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime get createdAt;
  @JsonKey(name: 'reporter_id')
  String? get reporterId;
  @JsonKey(name: 'offender_id')
  String? get offenderId;
  @JsonKey(name: 'description')
  String get description;
  @JsonKey(name: 'resolved_at')
  DateTime? get resolvedAt;
  @JsonKey(name: 'message_id')
  int? get chatMessageId;
  @JsonKey(name: 'attachments')
  @MediaFileConverter()
  List<MediaFile>? get attachments;
  @ChatMessageConverter()
  @JsonKey(name: 'message', includeToJson: false)
  ChatMessage? get chatMessage;
  @EESUpoolMemberConverter()
  @JsonKey(name: 'reporter_member', includeToJson: false)
  EESUpoolMember? get reporter;
  @EESUpoolMemberConverter()
  @JsonKey(name: 'offender_member', includeToJson: false)
  EESUpoolMember? get offender;

  /// Create a copy of EESUpoolIssue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EESUpoolIssueCopyWith<EESUpoolIssue> get copyWith =>
      _$EESUpoolIssueCopyWithImpl<EESUpoolIssue>(
          this as EESUpoolIssue, _$identity);

  /// Serializes this EESUpoolIssue to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
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
            other is EESUpoolIssue &&
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
                .equals(other.attachments, attachments) &&
            (identical(other.chatMessage, chatMessage) ||
                other.chatMessage == chatMessage) &&
            (identical(other.reporter, reporter) ||
                other.reporter == reporter) &&
            (identical(other.offender, offender) ||
                other.offender == offender));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
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
      const DeepCollectionEquality().hash(attachments),
      chatMessage,
      reporter,
      offender);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EESUpoolIssue(id: $id, eesupoolId: $eesupoolId, parentPoolId: $parentPoolId, createdAt: $createdAt, reporterId: $reporterId, offenderId: $offenderId, description: $description, resolvedAt: $resolvedAt, chatMessageId: $chatMessageId, attachments: $attachments, chatMessage: $chatMessage, reporter: $reporter, offender: $offender)';
  }
}

/// @nodoc
abstract mixin class $EESUpoolIssueCopyWith<$Res> {
  factory $EESUpoolIssueCopyWith(
          EESUpoolIssue value, $Res Function(EESUpoolIssue) _then) =
      _$EESUpoolIssueCopyWithImpl;
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
class _$EESUpoolIssueCopyWithImpl<$Res>
    implements $EESUpoolIssueCopyWith<$Res> {
  _$EESUpoolIssueCopyWithImpl(this._self, this._then);

  final EESUpoolIssue _self;
  final $Res Function(EESUpoolIssue) _then;

  /// Create a copy of EESUpoolIssue
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eesupoolId: null == eesupoolId
          ? _self.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      parentPoolId: freezed == parentPoolId
          ? _self.parentPoolId
          : parentPoolId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reporterId: freezed == reporterId
          ? _self.reporterId
          : reporterId // ignore: cast_nullable_to_non_nullable
              as String?,
      offenderId: freezed == offenderId
          ? _self.offenderId
          : offenderId // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      resolvedAt: freezed == resolvedAt
          ? _self.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      chatMessageId: freezed == chatMessageId
          ? _self.chatMessageId
          : chatMessageId // ignore: cast_nullable_to_non_nullable
              as int?,
      attachments: freezed == attachments
          ? _self.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<MediaFile>?,
      chatMessage: freezed == chatMessage
          ? _self.chatMessage
          : chatMessage // ignore: cast_nullable_to_non_nullable
              as ChatMessage?,
      reporter: freezed == reporter
          ? _self.reporter
          : reporter // ignore: cast_nullable_to_non_nullable
              as EESUpoolMember?,
      offender: freezed == offender
          ? _self.offender
          : offender // ignore: cast_nullable_to_non_nullable
              as EESUpoolMember?,
    ));
  }

  /// Create a copy of EESUpoolIssue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatMessageCopyWith<$Res>? get chatMessage {
    if (_self.chatMessage == null) {
      return null;
    }

    return $ChatMessageCopyWith<$Res>(_self.chatMessage!, (value) {
      return _then(_self.copyWith(chatMessage: value));
    });
  }

  /// Create a copy of EESUpoolIssue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EESUpoolMemberCopyWith<$Res>? get reporter {
    if (_self.reporter == null) {
      return null;
    }

    return $EESUpoolMemberCopyWith<$Res>(_self.reporter!, (value) {
      return _then(_self.copyWith(reporter: value));
    });
  }

  /// Create a copy of EESUpoolIssue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EESUpoolMemberCopyWith<$Res>? get offender {
    if (_self.offender == null) {
      return null;
    }

    return $EESUpoolMemberCopyWith<$Res>(_self.offender!, (value) {
      return _then(_self.copyWith(offender: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _EESUpoolIssue with DiagnosticableTreeMixin implements EESUpoolIssue {
  const _EESUpoolIssue(
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
  factory _EESUpoolIssue.fromJson(Map<String, dynamic> json) =>
      _$EESUpoolIssueFromJson(json);

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

  /// Create a copy of EESUpoolIssue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EESUpoolIssueCopyWith<_EESUpoolIssue> get copyWith =>
      __$EESUpoolIssueCopyWithImpl<_EESUpoolIssue>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EESUpoolIssueToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
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
            other is _EESUpoolIssue &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EESUpoolIssue(id: $id, eesupoolId: $eesupoolId, parentPoolId: $parentPoolId, createdAt: $createdAt, reporterId: $reporterId, offenderId: $offenderId, description: $description, resolvedAt: $resolvedAt, chatMessageId: $chatMessageId, attachments: $attachments, chatMessage: $chatMessage, reporter: $reporter, offender: $offender)';
  }
}

/// @nodoc
abstract mixin class _$EESUpoolIssueCopyWith<$Res>
    implements $EESUpoolIssueCopyWith<$Res> {
  factory _$EESUpoolIssueCopyWith(
          _EESUpoolIssue value, $Res Function(_EESUpoolIssue) _then) =
      __$EESUpoolIssueCopyWithImpl;
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
class __$EESUpoolIssueCopyWithImpl<$Res>
    implements _$EESUpoolIssueCopyWith<$Res> {
  __$EESUpoolIssueCopyWithImpl(this._self, this._then);

  final _EESUpoolIssue _self;
  final $Res Function(_EESUpoolIssue) _then;

  /// Create a copy of EESUpoolIssue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_EESUpoolIssue(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eesupoolId: null == eesupoolId
          ? _self.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      parentPoolId: freezed == parentPoolId
          ? _self.parentPoolId
          : parentPoolId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reporterId: freezed == reporterId
          ? _self.reporterId
          : reporterId // ignore: cast_nullable_to_non_nullable
              as String?,
      offenderId: freezed == offenderId
          ? _self.offenderId
          : offenderId // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      resolvedAt: freezed == resolvedAt
          ? _self.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      chatMessageId: freezed == chatMessageId
          ? _self.chatMessageId
          : chatMessageId // ignore: cast_nullable_to_non_nullable
              as int?,
      attachments: freezed == attachments
          ? _self._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<MediaFile>?,
      chatMessage: freezed == chatMessage
          ? _self.chatMessage
          : chatMessage // ignore: cast_nullable_to_non_nullable
              as ChatMessage?,
      reporter: freezed == reporter
          ? _self.reporter
          : reporter // ignore: cast_nullable_to_non_nullable
              as EESUpoolMember?,
      offender: freezed == offender
          ? _self.offender
          : offender // ignore: cast_nullable_to_non_nullable
              as EESUpoolMember?,
    ));
  }

  /// Create a copy of EESUpoolIssue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatMessageCopyWith<$Res>? get chatMessage {
    if (_self.chatMessage == null) {
      return null;
    }

    return $ChatMessageCopyWith<$Res>(_self.chatMessage!, (value) {
      return _then(_self.copyWith(chatMessage: value));
    });
  }

  /// Create a copy of EESUpoolIssue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EESUpoolMemberCopyWith<$Res>? get reporter {
    if (_self.reporter == null) {
      return null;
    }

    return $EESUpoolMemberCopyWith<$Res>(_self.reporter!, (value) {
      return _then(_self.copyWith(reporter: value));
    });
  }

  /// Create a copy of EESUpoolIssue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EESUpoolMemberCopyWith<$Res>? get offender {
    if (_self.offender == null) {
      return null;
    }

    return $EESUpoolMemberCopyWith<$Res>(_self.offender!, (value) {
      return _then(_self.copyWith(offender: value));
    });
  }
}

// dart format on
