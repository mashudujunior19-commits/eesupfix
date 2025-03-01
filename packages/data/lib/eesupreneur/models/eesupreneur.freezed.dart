// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eesupreneur.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EESUpreneur {
  @JsonKey(includeToJson: false)
  String get id;
  @JsonKey(name: 'owner_name', includeToJson: false)
  String? get ownerName;
  String get name;
  String? get description;
  @JsonKey(name: 'owner_id', includeToJson: false)
  String get ownerId;
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime? get createdAt;
  @JsonKey(name: 'delivery_fee')
  double? get deliveryFee;
  @JsonKey(name: 'is_hidden')
  bool? get isHidden;
  @JsonKey(name: 'is_active')
  bool?
      get isActive; //@JsonKey(name: 'schedule') required List<DaySchedule> daySchedule,
  @JsonKey(includeToJson: false)
  @AddressConverter()
  Address? get address;
  @JsonKey(includeToJson: false)
  double? get distance;

  /// Create a copy of EESUpreneur
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EESUpreneurCopyWith<EESUpreneur> get copyWith =>
      _$EESUpreneurCopyWithImpl<EESUpreneur>(this as EESUpreneur, _$identity);

  /// Serializes this EESUpreneur to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EESUpreneur &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ownerName, ownerName) ||
                other.ownerName == ownerName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.deliveryFee, deliveryFee) ||
                other.deliveryFee == deliveryFee) &&
            (identical(other.isHidden, isHidden) ||
                other.isHidden == isHidden) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.distance, distance) ||
                other.distance == distance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, ownerName, name, description,
      ownerId, createdAt, deliveryFee, isHidden, isActive, address, distance);

  @override
  String toString() {
    return 'EESUpreneur(id: $id, ownerName: $ownerName, name: $name, description: $description, ownerId: $ownerId, createdAt: $createdAt, deliveryFee: $deliveryFee, isHidden: $isHidden, isActive: $isActive, address: $address, distance: $distance)';
  }
}

/// @nodoc
abstract mixin class $EESUpreneurCopyWith<$Res> {
  factory $EESUpreneurCopyWith(
          EESUpreneur value, $Res Function(EESUpreneur) _then) =
      _$EESUpreneurCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String id,
      @JsonKey(name: 'owner_name', includeToJson: false) String? ownerName,
      String name,
      String? description,
      @JsonKey(name: 'owner_id', includeToJson: false) String ownerId,
      @JsonKey(name: 'created_at', includeToJson: false) DateTime? createdAt,
      @JsonKey(name: 'delivery_fee') double? deliveryFee,
      @JsonKey(name: 'is_hidden') bool? isHidden,
      @JsonKey(name: 'is_active') bool? isActive,
      @JsonKey(includeToJson: false) @AddressConverter() Address? address,
      @JsonKey(includeToJson: false) double? distance});

  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class _$EESUpreneurCopyWithImpl<$Res> implements $EESUpreneurCopyWith<$Res> {
  _$EESUpreneurCopyWithImpl(this._self, this._then);

  final EESUpreneur _self;
  final $Res Function(EESUpreneur) _then;

  /// Create a copy of EESUpreneur
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerName = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? ownerId = null,
    Object? createdAt = freezed,
    Object? deliveryFee = freezed,
    Object? isHidden = freezed,
    Object? isActive = freezed,
    Object? address = freezed,
    Object? distance = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName: freezed == ownerName
          ? _self.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: null == ownerId
          ? _self.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveryFee: freezed == deliveryFee
          ? _self.deliveryFee
          : deliveryFee // ignore: cast_nullable_to_non_nullable
              as double?,
      isHidden: freezed == isHidden
          ? _self.isHidden
          : isHidden // ignore: cast_nullable_to_non_nullable
              as bool?,
      isActive: freezed == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      distance: freezed == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }

  /// Create a copy of EESUpreneur
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_self.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_self.address!, (value) {
      return _then(_self.copyWith(address: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _EESUpreneur implements EESUpreneur {
  const _EESUpreneur(
      {@JsonKey(includeToJson: false) required this.id,
      @JsonKey(name: 'owner_name', includeToJson: false) this.ownerName,
      required this.name,
      this.description,
      @JsonKey(name: 'owner_id', includeToJson: false) required this.ownerId,
      @JsonKey(name: 'created_at', includeToJson: false) this.createdAt,
      @JsonKey(name: 'delivery_fee') this.deliveryFee,
      @JsonKey(name: 'is_hidden') this.isHidden,
      @JsonKey(name: 'is_active') this.isActive,
      @JsonKey(includeToJson: false) @AddressConverter() this.address,
      @JsonKey(includeToJson: false) this.distance});
  factory _EESUpreneur.fromJson(Map<String, dynamic> json) =>
      _$EESUpreneurFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final String id;
  @override
  @JsonKey(name: 'owner_name', includeToJson: false)
  final String? ownerName;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey(name: 'owner_id', includeToJson: false)
  final String ownerId;
  @override
  @JsonKey(name: 'created_at', includeToJson: false)
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'delivery_fee')
  final double? deliveryFee;
  @override
  @JsonKey(name: 'is_hidden')
  final bool? isHidden;
  @override
  @JsonKey(name: 'is_active')
  final bool? isActive;
//@JsonKey(name: 'schedule') required List<DaySchedule> daySchedule,
  @override
  @JsonKey(includeToJson: false)
  @AddressConverter()
  final Address? address;
  @override
  @JsonKey(includeToJson: false)
  final double? distance;

  /// Create a copy of EESUpreneur
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EESUpreneurCopyWith<_EESUpreneur> get copyWith =>
      __$EESUpreneurCopyWithImpl<_EESUpreneur>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EESUpreneurToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EESUpreneur &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ownerName, ownerName) ||
                other.ownerName == ownerName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.deliveryFee, deliveryFee) ||
                other.deliveryFee == deliveryFee) &&
            (identical(other.isHidden, isHidden) ||
                other.isHidden == isHidden) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.distance, distance) ||
                other.distance == distance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, ownerName, name, description,
      ownerId, createdAt, deliveryFee, isHidden, isActive, address, distance);

  @override
  String toString() {
    return 'EESUpreneur(id: $id, ownerName: $ownerName, name: $name, description: $description, ownerId: $ownerId, createdAt: $createdAt, deliveryFee: $deliveryFee, isHidden: $isHidden, isActive: $isActive, address: $address, distance: $distance)';
  }
}

/// @nodoc
abstract mixin class _$EESUpreneurCopyWith<$Res>
    implements $EESUpreneurCopyWith<$Res> {
  factory _$EESUpreneurCopyWith(
          _EESUpreneur value, $Res Function(_EESUpreneur) _then) =
      __$EESUpreneurCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String id,
      @JsonKey(name: 'owner_name', includeToJson: false) String? ownerName,
      String name,
      String? description,
      @JsonKey(name: 'owner_id', includeToJson: false) String ownerId,
      @JsonKey(name: 'created_at', includeToJson: false) DateTime? createdAt,
      @JsonKey(name: 'delivery_fee') double? deliveryFee,
      @JsonKey(name: 'is_hidden') bool? isHidden,
      @JsonKey(name: 'is_active') bool? isActive,
      @JsonKey(includeToJson: false) @AddressConverter() Address? address,
      @JsonKey(includeToJson: false) double? distance});

  @override
  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class __$EESUpreneurCopyWithImpl<$Res> implements _$EESUpreneurCopyWith<$Res> {
  __$EESUpreneurCopyWithImpl(this._self, this._then);

  final _EESUpreneur _self;
  final $Res Function(_EESUpreneur) _then;

  /// Create a copy of EESUpreneur
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? ownerName = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? ownerId = null,
    Object? createdAt = freezed,
    Object? deliveryFee = freezed,
    Object? isHidden = freezed,
    Object? isActive = freezed,
    Object? address = freezed,
    Object? distance = freezed,
  }) {
    return _then(_EESUpreneur(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName: freezed == ownerName
          ? _self.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: null == ownerId
          ? _self.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveryFee: freezed == deliveryFee
          ? _self.deliveryFee
          : deliveryFee // ignore: cast_nullable_to_non_nullable
              as double?,
      isHidden: freezed == isHidden
          ? _self.isHidden
          : isHidden // ignore: cast_nullable_to_non_nullable
              as bool?,
      isActive: freezed == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      distance: freezed == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }

  /// Create a copy of EESUpreneur
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_self.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_self.address!, (value) {
      return _then(_self.copyWith(address: value));
    });
  }
}

// dart format on
