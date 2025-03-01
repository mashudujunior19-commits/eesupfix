// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatMessage {
  @JsonKey(includeToJson: false)
  int get id;
  @JsonKey(name: 'eesupool_id')
  int get eesupoolId;
  @JsonKey(name: 'author_id')
  String get authorId;
  @JsonKey(name: 'created_at', includeToJson: true)
  DateTime get createdAt;
  @JsonKey(name: 'author_full_name', includeToJson: false)
  String? get authorName;
  @JsonKey(name: 'content')
  String? get content;
  @JsonKey(name: 'reply_on_id')
  int? get replyOnId;
  @JsonKey(name: 'attachments')
  @MediaFileConverter()
  List<MediaFile>? get media;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<File> get localFiles;
  @ChatMessageConverter()
  @JsonKey(name: 'reply_message', includeToJson: false)
  ChatMessage? get reply;
  @ChatMessageReactionConverter()
  @JsonKey(name: 'reactions', includeToJson: false)
  List<ChatMessageReaction>? get reactions;
  @JsonKey(name: 'hash_tags')
  List<String>? get hashTags;
  @JsonKey(name: 'is_approved')
  bool get isApproved;
  @JsonKey(name: 'is_deleted', includeToJson: false)
  bool get isDeleted;
  @EESUpoolLevelConverter()
  @JsonKey(name: 'broadcast_to')
  List<EESUpoolLevel>? get broadcastTo;
  @JsonKey(name: 'message_seens', includeToJson: false)
  List<String> get messageSeens;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      _$ChatMessageCopyWithImpl<ChatMessage>(this as ChatMessage, _$identity);

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatMessage &&
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
            const DeepCollectionEquality().equals(other.media, media) &&
            const DeepCollectionEquality()
                .equals(other.localFiles, localFiles) &&
            (identical(other.reply, reply) || other.reply == reply) &&
            const DeepCollectionEquality().equals(other.reactions, reactions) &&
            const DeepCollectionEquality().equals(other.hashTags, hashTags) &&
            (identical(other.isApproved, isApproved) ||
                other.isApproved == isApproved) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            const DeepCollectionEquality()
                .equals(other.broadcastTo, broadcastTo) &&
            const DeepCollectionEquality()
                .equals(other.messageSeens, messageSeens));
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
      const DeepCollectionEquality().hash(media),
      const DeepCollectionEquality().hash(localFiles),
      reply,
      const DeepCollectionEquality().hash(reactions),
      const DeepCollectionEquality().hash(hashTags),
      isApproved,
      isDeleted,
      const DeepCollectionEquality().hash(broadcastTo),
      const DeepCollectionEquality().hash(messageSeens));

  @override
  String toString() {
    return 'ChatMessage(id: $id, eesupoolId: $eesupoolId, authorId: $authorId, createdAt: $createdAt, authorName: $authorName, content: $content, replyOnId: $replyOnId, media: $media, localFiles: $localFiles, reply: $reply, reactions: $reactions, hashTags: $hashTags, isApproved: $isApproved, isDeleted: $isDeleted, broadcastTo: $broadcastTo, messageSeens: $messageSeens)';
  }
}

/// @nodoc
abstract mixin class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
          ChatMessage value, $Res Function(ChatMessage) _then) =
      _$ChatMessageCopyWithImpl;
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
class _$ChatMessageCopyWithImpl<$Res> implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._self, this._then);

  final ChatMessage _self;
  final $Res Function(ChatMessage) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eesupoolId: null == eesupoolId
          ? _self.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      authorId: null == authorId
          ? _self.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      authorName: freezed == authorName
          ? _self.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      replyOnId: freezed == replyOnId
          ? _self.replyOnId
          : replyOnId // ignore: cast_nullable_to_non_nullable
              as int?,
      media: freezed == media
          ? _self.media
          : media // ignore: cast_nullable_to_non_nullable
              as List<MediaFile>?,
      localFiles: null == localFiles
          ? _self.localFiles
          : localFiles // ignore: cast_nullable_to_non_nullable
              as List<File>,
      reply: freezed == reply
          ? _self.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as ChatMessage?,
      reactions: freezed == reactions
          ? _self.reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageReaction>?,
      hashTags: freezed == hashTags
          ? _self.hashTags
          : hashTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isApproved: null == isApproved
          ? _self.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _self.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      broadcastTo: freezed == broadcastTo
          ? _self.broadcastTo
          : broadcastTo // ignore: cast_nullable_to_non_nullable
              as List<EESUpoolLevel>?,
      messageSeens: null == messageSeens
          ? _self.messageSeens
          : messageSeens // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatMessageCopyWith<$Res>? get reply {
    if (_self.reply == null) {
      return null;
    }

    return $ChatMessageCopyWith<$Res>(_self.reply!, (value) {
      return _then(_self.copyWith(reply: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _ChatMessage implements ChatMessage {
  const _ChatMessage(
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
  factory _ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

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

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChatMessageCopyWith<_ChatMessage> get copyWith =>
      __$ChatMessageCopyWithImpl<_ChatMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChatMessageToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChatMessage &&
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

  @override
  String toString() {
    return 'ChatMessage(id: $id, eesupoolId: $eesupoolId, authorId: $authorId, createdAt: $createdAt, authorName: $authorName, content: $content, replyOnId: $replyOnId, media: $media, localFiles: $localFiles, reply: $reply, reactions: $reactions, hashTags: $hashTags, isApproved: $isApproved, isDeleted: $isDeleted, broadcastTo: $broadcastTo, messageSeens: $messageSeens)';
  }
}

/// @nodoc
abstract mixin class _$ChatMessageCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageCopyWith(
          _ChatMessage value, $Res Function(_ChatMessage) _then) =
      __$ChatMessageCopyWithImpl;
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
class __$ChatMessageCopyWithImpl<$Res> implements _$ChatMessageCopyWith<$Res> {
  __$ChatMessageCopyWithImpl(this._self, this._then);

  final _ChatMessage _self;
  final $Res Function(_ChatMessage) _then;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_ChatMessage(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eesupoolId: null == eesupoolId
          ? _self.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int,
      authorId: null == authorId
          ? _self.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      authorName: freezed == authorName
          ? _self.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      replyOnId: freezed == replyOnId
          ? _self.replyOnId
          : replyOnId // ignore: cast_nullable_to_non_nullable
              as int?,
      media: freezed == media
          ? _self._media
          : media // ignore: cast_nullable_to_non_nullable
              as List<MediaFile>?,
      localFiles: null == localFiles
          ? _self._localFiles
          : localFiles // ignore: cast_nullable_to_non_nullable
              as List<File>,
      reply: freezed == reply
          ? _self.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as ChatMessage?,
      reactions: freezed == reactions
          ? _self._reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as List<ChatMessageReaction>?,
      hashTags: freezed == hashTags
          ? _self._hashTags
          : hashTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isApproved: null == isApproved
          ? _self.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _self.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      broadcastTo: freezed == broadcastTo
          ? _self._broadcastTo
          : broadcastTo // ignore: cast_nullable_to_non_nullable
              as List<EESUpoolLevel>?,
      messageSeens: null == messageSeens
          ? _self._messageSeens
          : messageSeens // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatMessageCopyWith<$Res>? get reply {
    if (_self.reply == null) {
      return null;
    }

    return $ChatMessageCopyWith<$Res>(_self.reply!, (value) {
      return _then(_self.copyWith(reply: value));
    });
  }
}

// dart format on
