// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eesupool.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EESUpool _$EESUpoolFromJson(Map<String, dynamic> json) {
  return _EESUpool.fromJson(json);
}

/// @nodoc
mixin _$EESUpool {
  @JsonKey(name: 'eesupool_id', includeToJson: false)
  int? get eesupoolId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'admin_fee')
  double? get adminFee => throw _privateConstructorUsedError;
  @JsonKey(name: 'receiving_fee')
  double? get receivingFee => throw _privateConstructorUsedError;
  @JsonKey(name: 'collection_fee')
  double? get collectionFee => throw _privateConstructorUsedError;
  @JsonKey(name: 'packaging_fee')
  double? get packagingFee => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_public')
  bool get isPublic => throw _privateConstructorUsedError;
  @JsonKey(name: 'chat_enabled')
  bool get chatEnabled => throw _privateConstructorUsedError;
  int? get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'address_id')
  int? get addressId => throw _privateConstructorUsedError;
  @EESUpoolLevelConverter()
  @JsonKey(name: 'level', includeToJson: false)
  EESUpoolLevel? get level => throw _privateConstructorUsedError;
  @JsonKey(name: 'box_code')
  String? get boxCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'street_code')
  String? get streetCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_id')
  int? get parentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'chat_tags')
  List<String>? get chatTags => throw _privateConstructorUsedError;
  @JsonKey(name: 'chat_tags_suggestions')
  List<String>? get chatTagsSuggestions => throw _privateConstructorUsedError;
  @EESUpoolMemberRoleConverter()
  @JsonKey(includeToJson: false)
  EESUpoolMemberRole? get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_censored', includeToJson: false)
  bool? get isCensored => throw _privateConstructorUsedError;
  @EESUpoolTypeConverter()
  @JsonKey(includeToJson: false)
  EESUpoolType get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'member_id', includeToJson: false)
  String? get memberId => throw _privateConstructorUsedError;
  @JsonKey(name: 'num_members', includeToJson: false)
  int? get numMembers => throw _privateConstructorUsedError;
  @JsonKey(name: 'unseen_messages', includeToJson: false)
  int? get unseenMessages => throw _privateConstructorUsedError;
  @AddressConverter()
  @JsonKey(includeToJson: false)
  Address? get address => throw _privateConstructorUsedError;

  /// Serializes this EESUpool to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EESUpool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EESUpoolCopyWith<EESUpool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EESUpoolCopyWith<$Res> {
  factory $EESUpoolCopyWith(EESUpool value, $Res Function(EESUpool) then) =
      _$EESUpoolCopyWithImpl<$Res, EESUpool>;
  @useResult
  $Res call(
      {@JsonKey(name: 'eesupool_id', includeToJson: false) int? eesupoolId,
      String name,
      String? description,
      @JsonKey(name: 'admin_fee') double? adminFee,
      @JsonKey(name: 'receiving_fee') double? receivingFee,
      @JsonKey(name: 'collection_fee') double? collectionFee,
      @JsonKey(name: 'packaging_fee') double? packagingFee,
      @JsonKey(name: 'is_public') bool isPublic,
      @JsonKey(name: 'chat_enabled') bool chatEnabled,
      int? code,
      @JsonKey(name: 'address_id') int? addressId,
      @EESUpoolLevelConverter()
      @JsonKey(name: 'level', includeToJson: false)
      EESUpoolLevel? level,
      @JsonKey(name: 'box_code') String? boxCode,
      @JsonKey(name: 'street_code') String? streetCode,
      @JsonKey(name: 'parent_id') int? parentId,
      @JsonKey(name: 'chat_tags') List<String>? chatTags,
      @JsonKey(name: 'chat_tags_suggestions') List<String>? chatTagsSuggestions,
      @EESUpoolMemberRoleConverter()
      @JsonKey(includeToJson: false)
      EESUpoolMemberRole? role,
      @JsonKey(name: 'is_censored', includeToJson: false) bool? isCensored,
      @EESUpoolTypeConverter() @JsonKey(includeToJson: false) EESUpoolType type,
      @JsonKey(name: 'member_id', includeToJson: false) String? memberId,
      @JsonKey(name: 'num_members', includeToJson: false) int? numMembers,
      @JsonKey(name: 'unseen_messages', includeToJson: false)
      int? unseenMessages,
      @AddressConverter() @JsonKey(includeToJson: false) Address? address});

  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class _$EESUpoolCopyWithImpl<$Res, $Val extends EESUpool>
    implements $EESUpoolCopyWith<$Res> {
  _$EESUpoolCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EESUpool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eesupoolId = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? adminFee = freezed,
    Object? receivingFee = freezed,
    Object? collectionFee = freezed,
    Object? packagingFee = freezed,
    Object? isPublic = null,
    Object? chatEnabled = null,
    Object? code = freezed,
    Object? addressId = freezed,
    Object? level = freezed,
    Object? boxCode = freezed,
    Object? streetCode = freezed,
    Object? parentId = freezed,
    Object? chatTags = freezed,
    Object? chatTagsSuggestions = freezed,
    Object? role = freezed,
    Object? isCensored = freezed,
    Object? type = null,
    Object? memberId = freezed,
    Object? numMembers = freezed,
    Object? unseenMessages = freezed,
    Object? address = freezed,
  }) {
    return _then(_value.copyWith(
      eesupoolId: freezed == eesupoolId
          ? _value.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      adminFee: freezed == adminFee
          ? _value.adminFee
          : adminFee // ignore: cast_nullable_to_non_nullable
              as double?,
      receivingFee: freezed == receivingFee
          ? _value.receivingFee
          : receivingFee // ignore: cast_nullable_to_non_nullable
              as double?,
      collectionFee: freezed == collectionFee
          ? _value.collectionFee
          : collectionFee // ignore: cast_nullable_to_non_nullable
              as double?,
      packagingFee: freezed == packagingFee
          ? _value.packagingFee
          : packagingFee // ignore: cast_nullable_to_non_nullable
              as double?,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      chatEnabled: null == chatEnabled
          ? _value.chatEnabled
          : chatEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      addressId: freezed == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as int?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as EESUpoolLevel?,
      boxCode: freezed == boxCode
          ? _value.boxCode
          : boxCode // ignore: cast_nullable_to_non_nullable
              as String?,
      streetCode: freezed == streetCode
          ? _value.streetCode
          : streetCode // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      chatTags: freezed == chatTags
          ? _value.chatTags
          : chatTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      chatTagsSuggestions: freezed == chatTagsSuggestions
          ? _value.chatTagsSuggestions
          : chatTagsSuggestions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as EESUpoolMemberRole?,
      isCensored: freezed == isCensored
          ? _value.isCensored
          : isCensored // ignore: cast_nullable_to_non_nullable
              as bool?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as EESUpoolType,
      memberId: freezed == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String?,
      numMembers: freezed == numMembers
          ? _value.numMembers
          : numMembers // ignore: cast_nullable_to_non_nullable
              as int?,
      unseenMessages: freezed == unseenMessages
          ? _value.unseenMessages
          : unseenMessages // ignore: cast_nullable_to_non_nullable
              as int?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
    ) as $Val);
  }

  /// Create a copy of EESUpool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EESUpoolImplCopyWith<$Res>
    implements $EESUpoolCopyWith<$Res> {
  factory _$$EESUpoolImplCopyWith(
          _$EESUpoolImpl value, $Res Function(_$EESUpoolImpl) then) =
      __$$EESUpoolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'eesupool_id', includeToJson: false) int? eesupoolId,
      String name,
      String? description,
      @JsonKey(name: 'admin_fee') double? adminFee,
      @JsonKey(name: 'receiving_fee') double? receivingFee,
      @JsonKey(name: 'collection_fee') double? collectionFee,
      @JsonKey(name: 'packaging_fee') double? packagingFee,
      @JsonKey(name: 'is_public') bool isPublic,
      @JsonKey(name: 'chat_enabled') bool chatEnabled,
      int? code,
      @JsonKey(name: 'address_id') int? addressId,
      @EESUpoolLevelConverter()
      @JsonKey(name: 'level', includeToJson: false)
      EESUpoolLevel? level,
      @JsonKey(name: 'box_code') String? boxCode,
      @JsonKey(name: 'street_code') String? streetCode,
      @JsonKey(name: 'parent_id') int? parentId,
      @JsonKey(name: 'chat_tags') List<String>? chatTags,
      @JsonKey(name: 'chat_tags_suggestions') List<String>? chatTagsSuggestions,
      @EESUpoolMemberRoleConverter()
      @JsonKey(includeToJson: false)
      EESUpoolMemberRole? role,
      @JsonKey(name: 'is_censored', includeToJson: false) bool? isCensored,
      @EESUpoolTypeConverter() @JsonKey(includeToJson: false) EESUpoolType type,
      @JsonKey(name: 'member_id', includeToJson: false) String? memberId,
      @JsonKey(name: 'num_members', includeToJson: false) int? numMembers,
      @JsonKey(name: 'unseen_messages', includeToJson: false)
      int? unseenMessages,
      @AddressConverter() @JsonKey(includeToJson: false) Address? address});

  @override
  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class __$$EESUpoolImplCopyWithImpl<$Res>
    extends _$EESUpoolCopyWithImpl<$Res, _$EESUpoolImpl>
    implements _$$EESUpoolImplCopyWith<$Res> {
  __$$EESUpoolImplCopyWithImpl(
      _$EESUpoolImpl _value, $Res Function(_$EESUpoolImpl) _then)
      : super(_value, _then);

  /// Create a copy of EESUpool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eesupoolId = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? adminFee = freezed,
    Object? receivingFee = freezed,
    Object? collectionFee = freezed,
    Object? packagingFee = freezed,
    Object? isPublic = null,
    Object? chatEnabled = null,
    Object? code = freezed,
    Object? addressId = freezed,
    Object? level = freezed,
    Object? boxCode = freezed,
    Object? streetCode = freezed,
    Object? parentId = freezed,
    Object? chatTags = freezed,
    Object? chatTagsSuggestions = freezed,
    Object? role = freezed,
    Object? isCensored = freezed,
    Object? type = null,
    Object? memberId = freezed,
    Object? numMembers = freezed,
    Object? unseenMessages = freezed,
    Object? address = freezed,
  }) {
    return _then(_$EESUpoolImpl(
      eesupoolId: freezed == eesupoolId
          ? _value.eesupoolId
          : eesupoolId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      adminFee: freezed == adminFee
          ? _value.adminFee
          : adminFee // ignore: cast_nullable_to_non_nullable
              as double?,
      receivingFee: freezed == receivingFee
          ? _value.receivingFee
          : receivingFee // ignore: cast_nullable_to_non_nullable
              as double?,
      collectionFee: freezed == collectionFee
          ? _value.collectionFee
          : collectionFee // ignore: cast_nullable_to_non_nullable
              as double?,
      packagingFee: freezed == packagingFee
          ? _value.packagingFee
          : packagingFee // ignore: cast_nullable_to_non_nullable
              as double?,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      chatEnabled: null == chatEnabled
          ? _value.chatEnabled
          : chatEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      addressId: freezed == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as int?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as EESUpoolLevel?,
      boxCode: freezed == boxCode
          ? _value.boxCode
          : boxCode // ignore: cast_nullable_to_non_nullable
              as String?,
      streetCode: freezed == streetCode
          ? _value.streetCode
          : streetCode // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      chatTags: freezed == chatTags
          ? _value._chatTags
          : chatTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      chatTagsSuggestions: freezed == chatTagsSuggestions
          ? _value._chatTagsSuggestions
          : chatTagsSuggestions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as EESUpoolMemberRole?,
      isCensored: freezed == isCensored
          ? _value.isCensored
          : isCensored // ignore: cast_nullable_to_non_nullable
              as bool?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as EESUpoolType,
      memberId: freezed == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String?,
      numMembers: freezed == numMembers
          ? _value.numMembers
          : numMembers // ignore: cast_nullable_to_non_nullable
              as int?,
      unseenMessages: freezed == unseenMessages
          ? _value.unseenMessages
          : unseenMessages // ignore: cast_nullable_to_non_nullable
              as int?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EESUpoolImpl implements _EESUpool {
  const _$EESUpoolImpl(
      {@JsonKey(name: 'eesupool_id', includeToJson: false) this.eesupoolId,
      required this.name,
      this.description,
      @JsonKey(name: 'admin_fee') this.adminFee,
      @JsonKey(name: 'receiving_fee') this.receivingFee,
      @JsonKey(name: 'collection_fee') this.collectionFee,
      @JsonKey(name: 'packaging_fee') this.packagingFee,
      @JsonKey(name: 'is_public') this.isPublic = true,
      @JsonKey(name: 'chat_enabled') this.chatEnabled = false,
      this.code,
      @JsonKey(name: 'address_id') this.addressId,
      @EESUpoolLevelConverter()
      @JsonKey(name: 'level', includeToJson: false)
      this.level,
      @JsonKey(name: 'box_code') this.boxCode,
      @JsonKey(name: 'street_code') this.streetCode,
      @JsonKey(name: 'parent_id') this.parentId,
      @JsonKey(name: 'chat_tags') final List<String>? chatTags,
      @JsonKey(name: 'chat_tags_suggestions')
      final List<String>? chatTagsSuggestions,
      @EESUpoolMemberRoleConverter() @JsonKey(includeToJson: false) this.role,
      @JsonKey(name: 'is_censored', includeToJson: false) this.isCensored,
      @EESUpoolTypeConverter()
      @JsonKey(includeToJson: false)
      required this.type,
      @JsonKey(name: 'member_id', includeToJson: false) this.memberId,
      @JsonKey(name: 'num_members', includeToJson: false) this.numMembers,
      @JsonKey(name: 'unseen_messages', includeToJson: false)
      this.unseenMessages,
      @AddressConverter() @JsonKey(includeToJson: false) this.address})
      : _chatTags = chatTags,
        _chatTagsSuggestions = chatTagsSuggestions;

  factory _$EESUpoolImpl.fromJson(Map<String, dynamic> json) =>
      _$$EESUpoolImplFromJson(json);

  @override
  @JsonKey(name: 'eesupool_id', includeToJson: false)
  final int? eesupoolId;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey(name: 'admin_fee')
  final double? adminFee;
  @override
  @JsonKey(name: 'receiving_fee')
  final double? receivingFee;
  @override
  @JsonKey(name: 'collection_fee')
  final double? collectionFee;
  @override
  @JsonKey(name: 'packaging_fee')
  final double? packagingFee;
  @override
  @JsonKey(name: 'is_public')
  final bool isPublic;
  @override
  @JsonKey(name: 'chat_enabled')
  final bool chatEnabled;
  @override
  final int? code;
  @override
  @JsonKey(name: 'address_id')
  final int? addressId;
  @override
  @EESUpoolLevelConverter()
  @JsonKey(name: 'level', includeToJson: false)
  final EESUpoolLevel? level;
  @override
  @JsonKey(name: 'box_code')
  final String? boxCode;
  @override
  @JsonKey(name: 'street_code')
  final String? streetCode;
  @override
  @JsonKey(name: 'parent_id')
  final int? parentId;
  final List<String>? _chatTags;
  @override
  @JsonKey(name: 'chat_tags')
  List<String>? get chatTags {
    final value = _chatTags;
    if (value == null) return null;
    if (_chatTags is EqualUnmodifiableListView) return _chatTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _chatTagsSuggestions;
  @override
  @JsonKey(name: 'chat_tags_suggestions')
  List<String>? get chatTagsSuggestions {
    final value = _chatTagsSuggestions;
    if (value == null) return null;
    if (_chatTagsSuggestions is EqualUnmodifiableListView)
      return _chatTagsSuggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @EESUpoolMemberRoleConverter()
  @JsonKey(includeToJson: false)
  final EESUpoolMemberRole? role;
  @override
  @JsonKey(name: 'is_censored', includeToJson: false)
  final bool? isCensored;
  @override
  @EESUpoolTypeConverter()
  @JsonKey(includeToJson: false)
  final EESUpoolType type;
  @override
  @JsonKey(name: 'member_id', includeToJson: false)
  final String? memberId;
  @override
  @JsonKey(name: 'num_members', includeToJson: false)
  final int? numMembers;
  @override
  @JsonKey(name: 'unseen_messages', includeToJson: false)
  final int? unseenMessages;
  @override
  @AddressConverter()
  @JsonKey(includeToJson: false)
  final Address? address;

  @override
  String toString() {
    return 'EESUpool(eesupoolId: $eesupoolId, name: $name, description: $description, adminFee: $adminFee, receivingFee: $receivingFee, collectionFee: $collectionFee, packagingFee: $packagingFee, isPublic: $isPublic, chatEnabled: $chatEnabled, code: $code, addressId: $addressId, level: $level, boxCode: $boxCode, streetCode: $streetCode, parentId: $parentId, chatTags: $chatTags, chatTagsSuggestions: $chatTagsSuggestions, role: $role, isCensored: $isCensored, type: $type, memberId: $memberId, numMembers: $numMembers, unseenMessages: $unseenMessages, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EESUpoolImpl &&
            (identical(other.eesupoolId, eesupoolId) ||
                other.eesupoolId == eesupoolId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.adminFee, adminFee) ||
                other.adminFee == adminFee) &&
            (identical(other.receivingFee, receivingFee) ||
                other.receivingFee == receivingFee) &&
            (identical(other.collectionFee, collectionFee) ||
                other.collectionFee == collectionFee) &&
            (identical(other.packagingFee, packagingFee) ||
                other.packagingFee == packagingFee) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.chatEnabled, chatEnabled) ||
                other.chatEnabled == chatEnabled) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.addressId, addressId) ||
                other.addressId == addressId) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.boxCode, boxCode) || other.boxCode == boxCode) &&
            (identical(other.streetCode, streetCode) ||
                other.streetCode == streetCode) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            const DeepCollectionEquality().equals(other._chatTags, _chatTags) &&
            const DeepCollectionEquality()
                .equals(other._chatTagsSuggestions, _chatTagsSuggestions) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.isCensored, isCensored) ||
                other.isCensored == isCensored) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.numMembers, numMembers) ||
                other.numMembers == numMembers) &&
            (identical(other.unseenMessages, unseenMessages) ||
                other.unseenMessages == unseenMessages) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        eesupoolId,
        name,
        description,
        adminFee,
        receivingFee,
        collectionFee,
        packagingFee,
        isPublic,
        chatEnabled,
        code,
        addressId,
        level,
        boxCode,
        streetCode,
        parentId,
        const DeepCollectionEquality().hash(_chatTags),
        const DeepCollectionEquality().hash(_chatTagsSuggestions),
        role,
        isCensored,
        type,
        memberId,
        numMembers,
        unseenMessages,
        address
      ]);

  /// Create a copy of EESUpool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EESUpoolImplCopyWith<_$EESUpoolImpl> get copyWith =>
      __$$EESUpoolImplCopyWithImpl<_$EESUpoolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EESUpoolImplToJson(
      this,
    );
  }
}

abstract class _EESUpool implements EESUpool {
  const factory _EESUpool(
      {@JsonKey(name: 'eesupool_id', includeToJson: false)
      final int? eesupoolId,
      required final String name,
      final String? description,
      @JsonKey(name: 'admin_fee') final double? adminFee,
      @JsonKey(name: 'receiving_fee') final double? receivingFee,
      @JsonKey(name: 'collection_fee') final double? collectionFee,
      @JsonKey(name: 'packaging_fee') final double? packagingFee,
      @JsonKey(name: 'is_public') final bool isPublic,
      @JsonKey(name: 'chat_enabled') final bool chatEnabled,
      final int? code,
      @JsonKey(name: 'address_id') final int? addressId,
      @EESUpoolLevelConverter()
      @JsonKey(name: 'level', includeToJson: false)
      final EESUpoolLevel? level,
      @JsonKey(name: 'box_code') final String? boxCode,
      @JsonKey(name: 'street_code') final String? streetCode,
      @JsonKey(name: 'parent_id') final int? parentId,
      @JsonKey(name: 'chat_tags') final List<String>? chatTags,
      @JsonKey(name: 'chat_tags_suggestions')
      final List<String>? chatTagsSuggestions,
      @EESUpoolMemberRoleConverter()
      @JsonKey(includeToJson: false)
      final EESUpoolMemberRole? role,
      @JsonKey(name: 'is_censored', includeToJson: false)
      final bool? isCensored,
      @EESUpoolTypeConverter()
      @JsonKey(includeToJson: false)
      required final EESUpoolType type,
      @JsonKey(name: 'member_id', includeToJson: false) final String? memberId,
      @JsonKey(name: 'num_members', includeToJson: false) final int? numMembers,
      @JsonKey(name: 'unseen_messages', includeToJson: false)
      final int? unseenMessages,
      @AddressConverter()
      @JsonKey(includeToJson: false)
      final Address? address}) = _$EESUpoolImpl;

  factory _EESUpool.fromJson(Map<String, dynamic> json) =
      _$EESUpoolImpl.fromJson;

  @override
  @JsonKey(name: 'eesupool_id', includeToJson: false)
  int? get eesupoolId;
  @override
  String get name;
  @override
  String? get description;
  @override
  @JsonKey(name: 'admin_fee')
  double? get adminFee;
  @override
  @JsonKey(name: 'receiving_fee')
  double? get receivingFee;
  @override
  @JsonKey(name: 'collection_fee')
  double? get collectionFee;
  @override
  @JsonKey(name: 'packaging_fee')
  double? get packagingFee;
  @override
  @JsonKey(name: 'is_public')
  bool get isPublic;
  @override
  @JsonKey(name: 'chat_enabled')
  bool get chatEnabled;
  @override
  int? get code;
  @override
  @JsonKey(name: 'address_id')
  int? get addressId;
  @override
  @EESUpoolLevelConverter()
  @JsonKey(name: 'level', includeToJson: false)
  EESUpoolLevel? get level;
  @override
  @JsonKey(name: 'box_code')
  String? get boxCode;
  @override
  @JsonKey(name: 'street_code')
  String? get streetCode;
  @override
  @JsonKey(name: 'parent_id')
  int? get parentId;
  @override
  @JsonKey(name: 'chat_tags')
  List<String>? get chatTags;
  @override
  @JsonKey(name: 'chat_tags_suggestions')
  List<String>? get chatTagsSuggestions;
  @override
  @EESUpoolMemberRoleConverter()
  @JsonKey(includeToJson: false)
  EESUpoolMemberRole? get role;
  @override
  @JsonKey(name: 'is_censored', includeToJson: false)
  bool? get isCensored;
  @override
  @EESUpoolTypeConverter()
  @JsonKey(includeToJson: false)
  EESUpoolType get type;
  @override
  @JsonKey(name: 'member_id', includeToJson: false)
  String? get memberId;
  @override
  @JsonKey(name: 'num_members', includeToJson: false)
  int? get numMembers;
  @override
  @JsonKey(name: 'unseen_messages', includeToJson: false)
  int? get unseenMessages;
  @override
  @AddressConverter()
  @JsonKey(includeToJson: false)
  Address? get address;

  /// Create a copy of EESUpool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EESUpoolImplCopyWith<_$EESUpoolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
