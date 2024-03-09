// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eesupreneur.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EESUpreneur _$EESUpreneurFromJson(Map<String, dynamic> json) {
  return _EESUpreneur.fromJson(json);
}

/// @nodoc
mixin _$EESUpreneur {
  @JsonKey(includeToJson: false)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'owner_name', includeToJson: false)
  String? get ownerName => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'owner_id', includeToJson: false)
  String get ownerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivery_fee')
  double? get deliveryFee => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_hidden')
  bool? get isHidden => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool? get isActive =>
      throw _privateConstructorUsedError; //@JsonKey(name: 'schedule') required List<DaySchedule> daySchedule,
  @JsonKey(includeToJson: false)
  @AddressConverter()
  Address? get address => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  double? get distance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EESUpreneurCopyWith<EESUpreneur> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EESUpreneurCopyWith<$Res> {
  factory $EESUpreneurCopyWith(
          EESUpreneur value, $Res Function(EESUpreneur) then) =
      _$EESUpreneurCopyWithImpl<$Res, EESUpreneur>;
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
class _$EESUpreneurCopyWithImpl<$Res, $Val extends EESUpreneur>
    implements $EESUpreneurCopyWith<$Res> {
  _$EESUpreneurCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName: freezed == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveryFee: freezed == deliveryFee
          ? _value.deliveryFee
          : deliveryFee // ignore: cast_nullable_to_non_nullable
              as double?,
      isHidden: freezed == isHidden
          ? _value.isHidden
          : isHidden // ignore: cast_nullable_to_non_nullable
              as bool?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

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
abstract class _$$EESUpreneurImplCopyWith<$Res>
    implements $EESUpreneurCopyWith<$Res> {
  factory _$$EESUpreneurImplCopyWith(
          _$EESUpreneurImpl value, $Res Function(_$EESUpreneurImpl) then) =
      __$$EESUpreneurImplCopyWithImpl<$Res>;
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
class __$$EESUpreneurImplCopyWithImpl<$Res>
    extends _$EESUpreneurCopyWithImpl<$Res, _$EESUpreneurImpl>
    implements _$$EESUpreneurImplCopyWith<$Res> {
  __$$EESUpreneurImplCopyWithImpl(
      _$EESUpreneurImpl _value, $Res Function(_$EESUpreneurImpl) _then)
      : super(_value, _then);

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
    return _then(_$EESUpreneurImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName: freezed == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveryFee: freezed == deliveryFee
          ? _value.deliveryFee
          : deliveryFee // ignore: cast_nullable_to_non_nullable
              as double?,
      isHidden: freezed == isHidden
          ? _value.isHidden
          : isHidden // ignore: cast_nullable_to_non_nullable
              as bool?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EESUpreneurImpl implements _EESUpreneur {
  const _$EESUpreneurImpl(
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

  factory _$EESUpreneurImpl.fromJson(Map<String, dynamic> json) =>
      _$$EESUpreneurImplFromJson(json);

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

  @override
  String toString() {
    return 'EESUpreneur(id: $id, ownerName: $ownerName, name: $name, description: $description, ownerId: $ownerId, createdAt: $createdAt, deliveryFee: $deliveryFee, isHidden: $isHidden, isActive: $isActive, address: $address, distance: $distance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EESUpreneurImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, ownerName, name, description,
      ownerId, createdAt, deliveryFee, isHidden, isActive, address, distance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EESUpreneurImplCopyWith<_$EESUpreneurImpl> get copyWith =>
      __$$EESUpreneurImplCopyWithImpl<_$EESUpreneurImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EESUpreneurImplToJson(
      this,
    );
  }
}

abstract class _EESUpreneur implements EESUpreneur {
  const factory _EESUpreneur(
      {@JsonKey(includeToJson: false) required final String id,
      @JsonKey(name: 'owner_name', includeToJson: false)
      final String? ownerName,
      required final String name,
      final String? description,
      @JsonKey(name: 'owner_id', includeToJson: false)
      required final String ownerId,
      @JsonKey(name: 'created_at', includeToJson: false)
      final DateTime? createdAt,
      @JsonKey(name: 'delivery_fee') final double? deliveryFee,
      @JsonKey(name: 'is_hidden') final bool? isHidden,
      @JsonKey(name: 'is_active') final bool? isActive,
      @JsonKey(includeToJson: false) @AddressConverter() final Address? address,
      @JsonKey(includeToJson: false)
      final double? distance}) = _$EESUpreneurImpl;

  factory _EESUpreneur.fromJson(Map<String, dynamic> json) =
      _$EESUpreneurImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  String get id;
  @override
  @JsonKey(name: 'owner_name', includeToJson: false)
  String? get ownerName;
  @override
  String get name;
  @override
  String? get description;
  @override
  @JsonKey(name: 'owner_id', includeToJson: false)
  String get ownerId;
  @override
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'delivery_fee')
  double? get deliveryFee;
  @override
  @JsonKey(name: 'is_hidden')
  bool? get isHidden;
  @override
  @JsonKey(name: 'is_active')
  bool? get isActive;
  @override //@JsonKey(name: 'schedule') required List<DaySchedule> daySchedule,
  @JsonKey(includeToJson: false)
  @AddressConverter()
  Address? get address;
  @override
  @JsonKey(includeToJson: false)
  double? get distance;
  @override
  @JsonKey(ignore: true)
  _$$EESUpreneurImplCopyWith<_$EESUpreneurImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
