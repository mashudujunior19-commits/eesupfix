// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message_reaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatMessageReaction _$ChatMessageReactionFromJson(Map<String, dynamic> json) {
  return _ChatMessageReaction.fromJson(json);
}

/// @nodoc
mixin _$ChatMessageReaction {
  @JsonKey(name: 'message_id')
  int get messageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'member_id')
  String get memberId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'member_full_name', includeToJson: false)
  String get memberName => throw _privateConstructorUsedError;
  bool get liked => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatMessageReactionCopyWith<ChatMessageReaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageReactionCopyWith<$Res> {
  factory $ChatMessageReactionCopyWith(
          ChatMessageReaction value, $Res Function(ChatMessageReaction) then) =
      _$ChatMessageReactionCopyWithImpl<$Res, ChatMessageReaction>;
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
class _$ChatMessageReactionCopyWithImpl<$Res, $Val extends ChatMessageReaction>
    implements $ChatMessageReactionCopyWith<$Res> {
  _$ChatMessageReactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? memberId = null,
    Object? createdAt = null,
    Object? memberName = null,
    Object? liked = null,
  }) {
    return _then(_value.copyWith(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as int,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      memberName: null == memberName
          ? _value.memberName
          : memberName // ignore: cast_nullable_to_non_nullable
              as String,
      liked: null == liked
          ? _value.liked
          : liked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatMessageReactionImplCopyWith<$Res>
    implements $ChatMessageReactionCopyWith<$Res> {
  factory _$$ChatMessageReactionImplCopyWith(_$ChatMessageReactionImpl value,
          $Res Function(_$ChatMessageReactionImpl) then) =
      __$$ChatMessageReactionImplCopyWithImpl<$Res>;
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
class __$$ChatMessageReactionImplCopyWithImpl<$Res>
    extends _$ChatMessageReactionCopyWithImpl<$Res, _$ChatMessageReactionImpl>
    implements _$$ChatMessageReactionImplCopyWith<$Res> {
  __$$ChatMessageReactionImplCopyWithImpl(_$ChatMessageReactionImpl _value,
      $Res Function(_$ChatMessageReactionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? memberId = null,
    Object? createdAt = null,
    Object? memberName = null,
    Object? liked = null,
  }) {
    return _then(_$ChatMessageReactionImpl(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as int,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      memberName: null == memberName
          ? _value.memberName
          : memberName // ignore: cast_nullable_to_non_nullable
              as String,
      liked: null == liked
          ? _value.liked
          : liked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageReactionImpl implements _ChatMessageReaction {
  const _$ChatMessageReactionImpl(
      {@JsonKey(name: 'message_id') required this.messageId,
      @JsonKey(name: 'member_id') required this.memberId,
      @JsonKey(name: 'created_at', includeToJson: false)
      required this.createdAt,
      @JsonKey(name: 'member_full_name', includeToJson: false)
      required this.memberName,
      required this.liked});

  factory _$ChatMessageReactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageReactionImplFromJson(json);

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

  @override
  String toString() {
    return 'ChatMessageReaction(messageId: $messageId, memberId: $memberId, createdAt: $createdAt, memberName: $memberName, liked: $liked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageReactionImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, messageId, memberId, createdAt, memberName, liked);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageReactionImplCopyWith<_$ChatMessageReactionImpl> get copyWith =>
      __$$ChatMessageReactionImplCopyWithImpl<_$ChatMessageReactionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageReactionImplToJson(
      this,
    );
  }
}

abstract class _ChatMessageReaction implements ChatMessageReaction {
  const factory _ChatMessageReaction(
      {@JsonKey(name: 'message_id') required final int messageId,
      @JsonKey(name: 'member_id') required final String memberId,
      @JsonKey(name: 'created_at', includeToJson: false)
      required final DateTime createdAt,
      @JsonKey(name: 'member_full_name', includeToJson: false)
      required final String memberName,
      required final bool liked}) = _$ChatMessageReactionImpl;

  factory _ChatMessageReaction.fromJson(Map<String, dynamic> json) =
      _$ChatMessageReactionImpl.fromJson;

  @override
  @JsonKey(name: 'message_id')
  int get messageId;
  @override
  @JsonKey(name: 'member_id')
  String get memberId;
  @override
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime get createdAt;
  @override
  @JsonKey(name: 'member_full_name', includeToJson: false)
  String get memberName;
  @override
  bool get liked;
  @override
  @JsonKey(ignore: true)
  _$$ChatMessageReactionImplCopyWith<_$ChatMessageReactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
