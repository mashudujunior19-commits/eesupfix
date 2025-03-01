// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message_reaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatMessageReaction {
  @JsonKey(name: 'message_id')
  int get messageId;
  @JsonKey(name: 'member_id')
  String get memberId;
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime get createdAt;
  @JsonKey(name: 'member_full_name', includeToJson: false)
  String get memberName;
  bool get liked;

  /// Create a copy of ChatMessageReaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatMessageReactionCopyWith<ChatMessageReaction> get copyWith =>
      _$ChatMessageReactionCopyWithImpl<ChatMessageReaction>(
          this as ChatMessageReaction, _$identity);

  /// Serializes this ChatMessageReaction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatMessageReaction &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.memberName, memberName) ||
                other.memberName == memberName) &&
            (identical(other.liked, liked) || other.liked == liked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, messageId, memberId, createdAt, memberName, liked);

  @override
  String toString() {
    return 'ChatMessageReaction(messageId: $messageId, memberId: $memberId, createdAt: $createdAt, memberName: $memberName, liked: $liked)';
  }
}

/// @nodoc
abstract mixin class $ChatMessageReactionCopyWith<$Res> {
  factory $ChatMessageReactionCopyWith(
          ChatMessageReaction value, $Res Function(ChatMessageReaction) _then) =
      _$ChatMessageReactionCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'message_id') int messageId,
      @JsonKey(name: 'member_id') String memberId,
      @JsonKey(name: 'created_at', includeToJson: false) DateTime createdAt,
      @JsonKey(name: 'member_full_name', includeToJson: false)
      String memberName,
      bool liked});
}

/// @nodoc
class _$ChatMessageReactionCopyWithImpl<$Res>
    implements $ChatMessageReactionCopyWith<$Res> {
  _$ChatMessageReactionCopyWithImpl(this._self, this._then);

  final ChatMessageReaction _self;
  final $Res Function(ChatMessageReaction) _then;

  /// Create a copy of ChatMessageReaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? memberId = null,
    Object? createdAt = null,
    Object? memberName = null,
    Object? liked = null,
  }) {
    return _then(_self.copyWith(
      messageId: null == messageId
          ? _self.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as int,
      memberId: null == memberId
          ? _self.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      memberName: null == memberName
          ? _self.memberName
          : memberName // ignore: cast_nullable_to_non_nullable
              as String,
      liked: null == liked
          ? _self.liked
          : liked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ChatMessageReaction implements ChatMessageReaction {
  const _ChatMessageReaction(
      {@JsonKey(name: 'message_id') required this.messageId,
      @JsonKey(name: 'member_id') required this.memberId,
      @JsonKey(name: 'created_at', includeToJson: false)
      required this.createdAt,
      @JsonKey(name: 'member_full_name', includeToJson: false)
      required this.memberName,
      required this.liked});
  factory _ChatMessageReaction.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageReactionFromJson(json);

  @override
  @JsonKey(name: 'message_id')
  final int messageId;
  @override
  @JsonKey(name: 'member_id')
  final String memberId;
  @override
  @JsonKey(name: 'created_at', includeToJson: false)
  final DateTime createdAt;
  @override
  @JsonKey(name: 'member_full_name', includeToJson: false)
  final String memberName;
  @override
  final bool liked;

  /// Create a copy of ChatMessageReaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChatMessageReactionCopyWith<_ChatMessageReaction> get copyWith =>
      __$ChatMessageReactionCopyWithImpl<_ChatMessageReaction>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChatMessageReactionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChatMessageReaction &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.memberName, memberName) ||
                other.memberName == memberName) &&
            (identical(other.liked, liked) || other.liked == liked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, messageId, memberId, createdAt, memberName, liked);

  @override
  String toString() {
    return 'ChatMessageReaction(messageId: $messageId, memberId: $memberId, createdAt: $createdAt, memberName: $memberName, liked: $liked)';
  }
}

/// @nodoc
abstract mixin class _$ChatMessageReactionCopyWith<$Res>
    implements $ChatMessageReactionCopyWith<$Res> {
  factory _$ChatMessageReactionCopyWith(_ChatMessageReaction value,
          $Res Function(_ChatMessageReaction) _then) =
      __$ChatMessageReactionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'message_id') int messageId,
      @JsonKey(name: 'member_id') String memberId,
      @JsonKey(name: 'created_at', includeToJson: false) DateTime createdAt,
      @JsonKey(name: 'member_full_name', includeToJson: false)
      String memberName,
      bool liked});
}

/// @nodoc
class __$ChatMessageReactionCopyWithImpl<$Res>
    implements _$ChatMessageReactionCopyWith<$Res> {
  __$ChatMessageReactionCopyWithImpl(this._self, this._then);

  final _ChatMessageReaction _self;
  final $Res Function(_ChatMessageReaction) _then;

  /// Create a copy of ChatMessageReaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? messageId = null,
    Object? memberId = null,
    Object? createdAt = null,
    Object? memberName = null,
    Object? liked = null,
  }) {
    return _then(_ChatMessageReaction(
      messageId: null == messageId
          ? _self.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as int,
      memberId: null == memberId
          ? _self.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      memberName: null == memberName
          ? _self.memberName
          : memberName // ignore: cast_nullable_to_non_nullable
              as String,
      liked: null == liked
          ? _self.liked
          : liked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
