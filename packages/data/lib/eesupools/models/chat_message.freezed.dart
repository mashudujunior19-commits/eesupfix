// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatMessage {
  @JsonKey(includeToJson: false)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'eesupool_id')
  int get eesupoolId => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_id')
  String get authorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', includeToJson: true)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_full_name', includeToJson: false)
  String? get authorName => throw _privateConstructorUsedError;
  @JsonKey(name: 'content')
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'reply_on_id')
  int? get replyOnId => throw _privateConstructorUsedError;
  @JsonKey(name: 'attachments')
  @MediaFileConverter()
  List<MediaFile>? get media => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<File> get localFiles => throw _privateConstructorUsedError;
  @ChatMessageConverter()
  @JsonKey(name: 'reply_message', includeToJson: false)
  ChatMessage? get reply => throw _privateConstructorUsedError;
  @ChatMessageReactionConverter()
  @JsonKey(name: 'reactions', includeToJson: false)
  List<ChatMessageReaction>? get reactions =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'hash_tags')
  List<String>? get hashTags => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_approved')
  bool get isApproved => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_deleted', includeToJson: false)
  bool get isDeleted => throw _privateConstructorUsedError;
  @EESUpoolLevelConverter()
  @JsonKey(name: 'broadcast_to')
  List<EESUpoolLevel>? get broadcastTo => throw _privateConstructorUsedError;
  @JsonKey(name: 'message_seens', includeToJson: false)
  List<String> get messageSeens => throw _privateConstructorUsedError;

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
          ChatMessage value, $Res Function(ChatMessage) then) =
      _$ChatMessageCopyWithImpl<$Res, ChatMessage>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int id,
      @JsonKey(name: 'eesupool_id') int eesupoolId,
      @JsonKey(name: 'author_id') String authorId,
      @JsonKey(name: 'created_at', includeToJson: true) DateTime createdAt,
      @JsonKey(name: 'author_full_name', includeToJson: false)
      String? authorName,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'reply_on_id') int? replyOnId,
      @JsonKey(name: 'attachments')
      @MediaFileConverter()
      List<MediaFile>? media,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<File> localFiles,
      @ChatMessageConverter()
      @JsonKey(name: 'reply_message', includeToJson: false)
      ChatMessage? reply,
      @ChatMessageReactionConverter()
      @JsonKey(name: 'reactions', includeToJson: false)
      List<ChatMessageReaction>? reactions,
      @JsonKey(name: 'hash_tags') List<String>? hashTags,
      @JsonKey(name: 'is_approved') bool isApproved,
      @JsonKey(name: 'is_deleted', includeToJson: false) bool isDeleted,
      @EESUpoolLevelConverter()
      @JsonKey(name: 'broadcast_to')
      List<EESUpoolLevel>? broadcastTo,
      @JsonKey(name: 'message_seens', includeToJson: false)
      List<String> messageSeens});

  $ChatMessageCopyWith<$Res>? get reply;
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res, $Val extends ChatMessage>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eesupoolId = null,
    Object? authorId = null,
    Object? createdAt = null,
    Object? authorName = freezed,
    Object? content = freezed,
    Object? replyOnId = freezed,
    Object? media = freezed,
    Object? localFiles = null,
    Object? reply = freezed,
    Object? reactions = freezed,
    Object? hashTags = freezed,
    Object? isApproved = null,
    Object? isDeleted = null,
    Object? broadcastTo = freezed,
    Object? messageSeens = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eesupoolId: null == eesupoolId
          ? _value.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      authorName: freezed == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      replyOnId: freezed == replyOnId
          ? _value.replyOnId
          : replyOnId // ignore: cast_nullable_to_non_nullable
              as int?,
      media: freezed == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as List<MediaFile>?,
      localFiles: null == localFiles
          ? _value.localFiles
          : localFiles // ignore: cast_nullable_to_non_nullable
              as List<File>,
      reply: freezed == reply
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as ChatMessage?,
      reactions: freezed == reactions
          ? _value.reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageReaction>?,
      hashTags: freezed == hashTags
          ? _value.hashTags
          : hashTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isApproved: null == isApproved
          ? _value.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      broadcastTo: freezed == broadcastTo
          ? _value.broadcastTo
          : broadcastTo // ignore: cast_nullable_to_non_nullable
              as List<EESUpoolLevel>?,
      messageSeens: null == messageSeens
          ? _value.messageSeens
          : messageSeens // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatMessageCopyWith<$Res>? get reply {
    if (_value.reply == null) {
      return null;
    }

    return $ChatMessageCopyWith<$Res>(_value.reply!, (value) {
      return _then(_value.copyWith(reply: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatMessageImplCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$ChatMessageImplCopyWith(
          _$ChatMessageImpl value, $Res Function(_$ChatMessageImpl) then) =
      __$$ChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int id,
      @JsonKey(name: 'eesupool_id') int eesupoolId,
      @JsonKey(name: 'author_id') String authorId,
      @JsonKey(name: 'created_at', includeToJson: true) DateTime createdAt,
      @JsonKey(name: 'author_full_name', includeToJson: false)
      String? authorName,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'reply_on_id') int? replyOnId,
      @JsonKey(name: 'attachments')
      @MediaFileConverter()
      List<MediaFile>? media,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<File> localFiles,
      @ChatMessageConverter()
      @JsonKey(name: 'reply_message', includeToJson: false)
      ChatMessage? reply,
      @ChatMessageReactionConverter()
      @JsonKey(name: 'reactions', includeToJson: false)
      List<ChatMessageReaction>? reactions,
      @JsonKey(name: 'hash_tags') List<String>? hashTags,
      @JsonKey(name: 'is_approved') bool isApproved,
      @JsonKey(name: 'is_deleted', includeToJson: false) bool isDeleted,
      @EESUpoolLevelConverter()
      @JsonKey(name: 'broadcast_to')
      List<EESUpoolLevel>? broadcastTo,
      @JsonKey(name: 'message_seens', includeToJson: false)
      List<String> messageSeens});

  @override
  $ChatMessageCopyWith<$Res>? get reply;
}

/// @nodoc
class __$$ChatMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$ChatMessageImpl>
    implements _$$ChatMessageImplCopyWith<$Res> {
  __$$ChatMessageImplCopyWithImpl(
      _$ChatMessageImpl _value, $Res Function(_$ChatMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eesupoolId = null,
    Object? authorId = null,
    Object? createdAt = null,
    Object? authorName = freezed,
    Object? content = freezed,
    Object? replyOnId = freezed,
    Object? media = freezed,
    Object? localFiles = null,
    Object? reply = freezed,
    Object? reactions = freezed,
    Object? hashTags = freezed,
    Object? isApproved = null,
    Object? isDeleted = null,
    Object? broadcastTo = freezed,
    Object? messageSeens = null,
  }) {
    return _then(_$ChatMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eesupoolId: null == eesupoolId
          ? _value.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      authorName: freezed == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      replyOnId: freezed == replyOnId
          ? _value.replyOnId
          : replyOnId // ignore: cast_nullable_to_non_nullable
              as int?,
      media: freezed == media
          ? _value._media
          : media // ignore: cast_nullable_to_non_nullable
              as List<MediaFile>?,
      localFiles: null == localFiles
          ? _value._localFiles
          : localFiles // ignore: cast_nullable_to_non_nullable
              as List<File>,
      reply: freezed == reply
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as ChatMessage?,
      reactions: freezed == reactions
          ? _value._reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageReaction>?,
      hashTags: freezed == hashTags
          ? _value._hashTags
          : hashTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isApproved: null == isApproved
          ? _value.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      broadcastTo: freezed == broadcastTo
          ? _value._broadcastTo
          : broadcastTo // ignore: cast_nullable_to_non_nullable
              as List<EESUpoolLevel>?,
      messageSeens: null == messageSeens
          ? _value._messageSeens
          : messageSeens // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageImpl implements _ChatMessage {
  const _$ChatMessageImpl(
      {@JsonKey(includeToJson: false) required this.id,
      @JsonKey(name: 'eesupool_id') required this.eesupoolId,
      @JsonKey(name: 'author_id') required this.authorId,
      @JsonKey(name: 'created_at', includeToJson: true) required this.createdAt,
      @JsonKey(name: 'author_full_name', includeToJson: false) this.authorName,
      @JsonKey(name: 'content') this.content,
      @JsonKey(name: 'reply_on_id') this.replyOnId,
      @JsonKey(name: 'attachments')
      @MediaFileConverter()
      final List<MediaFile>? media,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<File> localFiles = const [],
      @ChatMessageConverter()
      @JsonKey(name: 'reply_message', includeToJson: false)
      this.reply,
      @ChatMessageReactionConverter()
      @JsonKey(name: 'reactions', includeToJson: false)
      final List<ChatMessageReaction>? reactions,
      @JsonKey(name: 'hash_tags') final List<String>? hashTags,
      @JsonKey(name: 'is_approved') required this.isApproved,
      @JsonKey(name: 'is_deleted', includeToJson: false)
      required this.isDeleted,
      @EESUpoolLevelConverter()
      @JsonKey(name: 'broadcast_to')
      final List<EESUpoolLevel>? broadcastTo,
      @JsonKey(name: 'message_seens', includeToJson: false)
      final List<String> messageSeens = const []})
      : _media = media,
        _localFiles = localFiles,
        _reactions = reactions,
        _hashTags = hashTags,
        _broadcastTo = broadcastTo,
        _messageSeens = messageSeens;

  factory _$ChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int id;
  @override
  @JsonKey(name: 'eesupool_id')
  final int eesupoolId;
  @override
  @JsonKey(name: 'author_id')
  final String authorId;
  @override
  @JsonKey(name: 'created_at', includeToJson: true)
  final DateTime createdAt;
  @override
  @JsonKey(name: 'author_full_name', includeToJson: false)
  final String? authorName;
  @override
  @JsonKey(name: 'content')
  final String? content;
  @override
  @JsonKey(name: 'reply_on_id')
  final int? replyOnId;
  final List<MediaFile>? _media;
  @override
  @JsonKey(name: 'attachments')
  @MediaFileConverter()
  List<MediaFile>? get media {
    final value = _media;
    if (value == null) return null;
    if (_media is EqualUnmodifiableListView) return _media;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<File> _localFiles;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<File> get localFiles {
    if (_localFiles is EqualUnmodifiableListView) return _localFiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_localFiles);
  }

  @override
  @ChatMessageConverter()
  @JsonKey(name: 'reply_message', includeToJson: false)
  final ChatMessage? reply;
  final List<ChatMessageReaction>? _reactions;
  @override
  @ChatMessageReactionConverter()
  @JsonKey(name: 'reactions', includeToJson: false)
  List<ChatMessageReaction>? get reactions {
    final value = _reactions;
    if (value == null) return null;
    if (_reactions is EqualUnmodifiableListView) return _reactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _hashTags;
  @override
  @JsonKey(name: 'hash_tags')
  List<String>? get hashTags {
    final value = _hashTags;
    if (value == null) return null;
    if (_hashTags is EqualUnmodifiableListView) return _hashTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'is_approved')
  final bool isApproved;
  @override
  @JsonKey(name: 'is_deleted', includeToJson: false)
  final bool isDeleted;
  final List<EESUpoolLevel>? _broadcastTo;
  @override
  @EESUpoolLevelConverter()
  @JsonKey(name: 'broadcast_to')
  List<EESUpoolLevel>? get broadcastTo {
    final value = _broadcastTo;
    if (value == null) return null;
    if (_broadcastTo is EqualUnmodifiableListView) return _broadcastTo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String> _messageSeens;
  @override
  @JsonKey(name: 'message_seens', includeToJson: false)
  List<String> get messageSeens {
    if (_messageSeens is EqualUnmodifiableListView) return _messageSeens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messageSeens);
  }

  @override
  String toString() {
    return 'ChatMessage(id: $id, eesupoolId: $eesupoolId, authorId: $authorId, createdAt: $createdAt, authorName: $authorName, content: $content, replyOnId: $replyOnId, media: $media, localFiles: $localFiles, reply: $reply, reactions: $reactions, hashTags: $hashTags, isApproved: $isApproved, isDeleted: $isDeleted, broadcastTo: $broadcastTo, messageSeens: $messageSeens)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eesupoolId, eesupoolId) ||
                other.eesupoolId == eesupoolId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.replyOnId, replyOnId) ||
                other.replyOnId == replyOnId) &&
            const DeepCollectionEquality().equals(other._media, _media) &&
            const DeepCollectionEquality()
                .equals(other._localFiles, _localFiles) &&
            (identical(other.reply, reply) || other.reply == reply) &&
            const DeepCollectionEquality()
                .equals(other._reactions, _reactions) &&
            const DeepCollectionEquality().equals(other._hashTags, _hashTags) &&
            (identical(other.isApproved, isApproved) ||
                other.isApproved == isApproved) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            const DeepCollectionEquality()
                .equals(other._broadcastTo, _broadcastTo) &&
            const DeepCollectionEquality()
                .equals(other._messageSeens, _messageSeens));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      eesupoolId,
      authorId,
      createdAt,
      authorName,
      content,
      replyOnId,
      const DeepCollectionEquality().hash(_media),
      const DeepCollectionEquality().hash(_localFiles),
      reply,
      const DeepCollectionEquality().hash(_reactions),
      const DeepCollectionEquality().hash(_hashTags),
      isApproved,
      isDeleted,
      const DeepCollectionEquality().hash(_broadcastTo),
      const DeepCollectionEquality().hash(_messageSeens));

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      __$$ChatMessageImplCopyWithImpl<_$ChatMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageImplToJson(
      this,
    );
  }
}

abstract class _ChatMessage implements ChatMessage {
  const factory _ChatMessage(
      {@JsonKey(includeToJson: false) required final int id,
      @JsonKey(name: 'eesupool_id') required final int eesupoolId,
      @JsonKey(name: 'author_id') required final String authorId,
      @JsonKey(name: 'created_at', includeToJson: true)
      required final DateTime createdAt,
      @JsonKey(name: 'author_full_name', includeToJson: false)
      final String? authorName,
      @JsonKey(name: 'content') final String? content,
      @JsonKey(name: 'reply_on_id') final int? replyOnId,
      @JsonKey(name: 'attachments')
      @MediaFileConverter()
      final List<MediaFile>? media,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<File> localFiles,
      @ChatMessageConverter()
      @JsonKey(name: 'reply_message', includeToJson: false)
      final ChatMessage? reply,
      @ChatMessageReactionConverter()
      @JsonKey(name: 'reactions', includeToJson: false)
      final List<ChatMessageReaction>? reactions,
      @JsonKey(name: 'hash_tags') final List<String>? hashTags,
      @JsonKey(name: 'is_approved') required final bool isApproved,
      @JsonKey(name: 'is_deleted', includeToJson: false)
      required final bool isDeleted,
      @EESUpoolLevelConverter()
      @JsonKey(name: 'broadcast_to')
      final List<EESUpoolLevel>? broadcastTo,
      @JsonKey(name: 'message_seens', includeToJson: false)
      final List<String> messageSeens}) = _$ChatMessageImpl;

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$ChatMessageImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  int get id;
  @override
  @JsonKey(name: 'eesupool_id')
  int get eesupoolId;
  @override
  @JsonKey(name: 'author_id')
  String get authorId;
  @override
  @JsonKey(name: 'created_at', includeToJson: true)
  DateTime get createdAt;
  @override
  @JsonKey(name: 'author_full_name', includeToJson: false)
  String? get authorName;
  @override
  @JsonKey(name: 'content')
  String? get content;
  @override
  @JsonKey(name: 'reply_on_id')
  int? get replyOnId;
  @override
  @JsonKey(name: 'attachments')
  @MediaFileConverter()
  List<MediaFile>? get media;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<File> get localFiles;
  @override
  @ChatMessageConverter()
  @JsonKey(name: 'reply_message', includeToJson: false)
  ChatMessage? get reply;
  @override
  @ChatMessageReactionConverter()
  @JsonKey(name: 'reactions', includeToJson: false)
  List<ChatMessageReaction>? get reactions;
  @override
  @JsonKey(name: 'hash_tags')
  List<String>? get hashTags;
  @override
  @JsonKey(name: 'is_approved')
  bool get isApproved;
  @override
  @JsonKey(name: 'is_deleted', includeToJson: false)
  bool get isDeleted;
  @override
  @EESUpoolLevelConverter()
  @JsonKey(name: 'broadcast_to')
  List<EESUpoolLevel>? get broadcastTo;
  @override
  @JsonKey(name: 'message_seens', includeToJson: false)
  List<String> get messageSeens;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
