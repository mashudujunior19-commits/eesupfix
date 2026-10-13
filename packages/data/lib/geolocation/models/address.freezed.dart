// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Address {
  @JsonKey(includeToJson: false)
  int? get id;
  @JsonKey(name: 'area_id')
  int? get areaId;
  @JsonKey(name: 'user_id')
  String? get userId;
  @JsonKey(name: 'recipient_name')
  String get recipientName;
  @JsonKey(name: 'recipient_phone')
  String get recipientPhone;
  @JsonKey(name: 'street_address')
  String get streetAddress;
  @JsonKey(name: 'building_name')
  String? get buildingName;
  @JsonKey(name: 'street_number')
  String? get streetNumber;
  @JsonKey(name: 'street_name')
  String? get streetName;
  String? get suburb;
  String? get city;
  @JsonKey(name: 'postal_code')
  String? get postalCode;
  @JsonKey(name: 'complex_name')
  String? get complexName;
  @JsonKey(name: 'unit_number')
  String? get unitNumber;
  String? get floor;
  String get type;
  String get province;
  double? get latitude;
  double? get longitude;
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime get createdAt;
  @JsonKey(name: 'is_primary')
  bool get isPrimary;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AddressCopyWith<Address> get copyWith =>
      _$AddressCopyWithImpl<Address>(this as Address, _$identity);

  /// Serializes this Address to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Address &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.areaId, areaId) || other.areaId == areaId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.recipientName, recipientName) ||
                other.recipientName == recipientName) &&
            (identical(other.recipientPhone, recipientPhone) ||
                other.recipientPhone == recipientPhone) &&
            (identical(other.streetAddress, streetAddress) ||
                other.streetAddress == streetAddress) &&
            (identical(other.buildingName, buildingName) ||
                other.buildingName == buildingName) &&
            (identical(other.streetNumber, streetNumber) ||
                other.streetNumber == streetNumber) &&
            (identical(other.streetName, streetName) ||
                other.streetName == streetName) &&
            (identical(other.suburb, suburb) || other.suburb == suburb) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.complexName, complexName) ||
                other.complexName == complexName) &&
            (identical(other.unitNumber, unitNumber) ||
                other.unitNumber == unitNumber) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.province, province) ||
                other.province == province) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isPrimary, isPrimary) ||
                other.isPrimary == isPrimary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        areaId,
        userId,
        recipientName,
        recipientPhone,
        streetAddress,
        buildingName,
        streetNumber,
        streetName,
        suburb,
        city,
        postalCode,
        complexName,
        unitNumber,
        floor,
        type,
        province,
        latitude,
        longitude,
        createdAt,
        isPrimary
      ]);

  @override
  String toString() {
    return 'Address(id: $id, areaId: $areaId, userId: $userId, recipientName: $recipientName, recipientPhone: $recipientPhone, streetAddress: $streetAddress, buildingName: $buildingName, streetNumber: $streetNumber, streetName: $streetName, suburb: $suburb, city: $city, postalCode: $postalCode, complexName: $complexName, unitNumber: $unitNumber, floor: $floor, type: $type, province: $province, latitude: $latitude, longitude: $longitude, createdAt: $createdAt, isPrimary: $isPrimary)';
  }
}

/// @nodoc
abstract mixin class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) _then) =
      _$AddressCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int? id,
      @JsonKey(name: 'area_id') int? areaId,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'recipient_name') String recipientName,
      @JsonKey(name: 'recipient_phone') String recipientPhone,
      @JsonKey(name: 'street_address') String streetAddress,
      @JsonKey(name: 'building_name') String? buildingName,
      @JsonKey(name: 'street_number') String? streetNumber,
      @JsonKey(name: 'street_name') String? streetName,
      String? suburb,
      String? city,
      @JsonKey(name: 'postal_code') String? postalCode,
      @JsonKey(name: 'complex_name') String? complexName,
      @JsonKey(name: 'unit_number') String? unitNumber,
      String? floor,
      String type,
      String province,
      double? latitude,
      double? longitude,
      @JsonKey(name: 'created_at', includeToJson: false) DateTime createdAt,
      @JsonKey(name: 'is_primary') bool isPrimary});
}

/// @nodoc
class _$AddressCopyWithImpl<$Res> implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._self, this._then);

  final Address _self;
  final $Res Function(Address) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? areaId = freezed,
    Object? userId = freezed,
    Object? recipientName = null,
    Object? recipientPhone = null,
    Object? streetAddress = null,
    Object? buildingName = freezed,
    Object? streetNumber = freezed,
    Object? streetName = freezed,
    Object? suburb = freezed,
    Object? city = freezed,
    Object? postalCode = freezed,
    Object? complexName = freezed,
    Object? unitNumber = freezed,
    Object? floor = freezed,
    Object? type = null,
    Object? province = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? createdAt = null,
    Object? isPrimary = null,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      areaId: freezed == areaId
          ? _self.areaId
          : areaId // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      recipientName: null == recipientName
          ? _self.recipientName
          : recipientName // ignore: cast_nullable_to_non_nullable
              as String,
      recipientPhone: null == recipientPhone
          ? _self.recipientPhone
          : recipientPhone // ignore: cast_nullable_to_non_nullable
              as String,
      streetAddress: null == streetAddress
          ? _self.streetAddress
          : streetAddress // ignore: cast_nullable_to_non_nullable
              as String,
      buildingName: freezed == buildingName
          ? _self.buildingName
          : buildingName // ignore: cast_nullable_to_non_nullable
              as String?,
      streetNumber: freezed == streetNumber
          ? _self.streetNumber
          : streetNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      streetName: freezed == streetName
          ? _self.streetName
          : streetName // ignore: cast_nullable_to_non_nullable
              as String?,
      suburb: freezed == suburb
          ? _self.suburb
          : suburb // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: freezed == postalCode
          ? _self.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      complexName: freezed == complexName
          ? _self.complexName
          : complexName // ignore: cast_nullable_to_non_nullable
              as String?,
      unitNumber: freezed == unitNumber
          ? _self.unitNumber
          : unitNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      floor: freezed == floor
          ? _self.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      province: null == province
          ? _self.province
          : province // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: freezed == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isPrimary: null == isPrimary
          ? _self.isPrimary
          : isPrimary // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [Address].
extension AddressPatterns on Address {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Address value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Address() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Address value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Address():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Address value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Address() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @JsonKey(includeToJson: false) int? id,
            @JsonKey(name: 'area_id') int? areaId,
            @JsonKey(name: 'user_id') String? userId,
            @JsonKey(name: 'recipient_name') String recipientName,
            @JsonKey(name: 'recipient_phone') String recipientPhone,
            @JsonKey(name: 'street_address') String streetAddress,
            @JsonKey(name: 'building_name') String? buildingName,
            @JsonKey(name: 'street_number') String? streetNumber,
            @JsonKey(name: 'street_name') String? streetName,
            String? suburb,
            String? city,
            @JsonKey(name: 'postal_code') String? postalCode,
            @JsonKey(name: 'complex_name') String? complexName,
            @JsonKey(name: 'unit_number') String? unitNumber,
            String? floor,
            String type,
            String province,
            double? latitude,
            double? longitude,
            @JsonKey(name: 'created_at', includeToJson: false)
            DateTime createdAt,
            @JsonKey(name: 'is_primary') bool isPrimary)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Address() when $default != null:
        return $default(
            _that.id,
            _that.areaId,
            _that.userId,
            _that.recipientName,
            _that.recipientPhone,
            _that.streetAddress,
            _that.buildingName,
            _that.streetNumber,
            _that.streetName,
            _that.suburb,
            _that.city,
            _that.postalCode,
            _that.complexName,
            _that.unitNumber,
            _that.floor,
            _that.type,
            _that.province,
            _that.latitude,
            _that.longitude,
            _that.createdAt,
            _that.isPrimary);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @JsonKey(includeToJson: false) int? id,
            @JsonKey(name: 'area_id') int? areaId,
            @JsonKey(name: 'user_id') String? userId,
            @JsonKey(name: 'recipient_name') String recipientName,
            @JsonKey(name: 'recipient_phone') String recipientPhone,
            @JsonKey(name: 'street_address') String streetAddress,
            @JsonKey(name: 'building_name') String? buildingName,
            @JsonKey(name: 'street_number') String? streetNumber,
            @JsonKey(name: 'street_name') String? streetName,
            String? suburb,
            String? city,
            @JsonKey(name: 'postal_code') String? postalCode,
            @JsonKey(name: 'complex_name') String? complexName,
            @JsonKey(name: 'unit_number') String? unitNumber,
            String? floor,
            String type,
            String province,
            double? latitude,
            double? longitude,
            @JsonKey(name: 'created_at', includeToJson: false)
            DateTime createdAt,
            @JsonKey(name: 'is_primary') bool isPrimary)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Address():
        return $default(
            _that.id,
            _that.areaId,
            _that.userId,
            _that.recipientName,
            _that.recipientPhone,
            _that.streetAddress,
            _that.buildingName,
            _that.streetNumber,
            _that.streetName,
            _that.suburb,
            _that.city,
            _that.postalCode,
            _that.complexName,
            _that.unitNumber,
            _that.floor,
            _that.type,
            _that.province,
            _that.latitude,
            _that.longitude,
            _that.createdAt,
            _that.isPrimary);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @JsonKey(includeToJson: false) int? id,
            @JsonKey(name: 'area_id') int? areaId,
            @JsonKey(name: 'user_id') String? userId,
            @JsonKey(name: 'recipient_name') String recipientName,
            @JsonKey(name: 'recipient_phone') String recipientPhone,
            @JsonKey(name: 'street_address') String streetAddress,
            @JsonKey(name: 'building_name') String? buildingName,
            @JsonKey(name: 'street_number') String? streetNumber,
            @JsonKey(name: 'street_name') String? streetName,
            String? suburb,
            String? city,
            @JsonKey(name: 'postal_code') String? postalCode,
            @JsonKey(name: 'complex_name') String? complexName,
            @JsonKey(name: 'unit_number') String? unitNumber,
            String? floor,
            String type,
            String province,
            double? latitude,
            double? longitude,
            @JsonKey(name: 'created_at', includeToJson: false)
            DateTime createdAt,
            @JsonKey(name: 'is_primary') bool isPrimary)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Address() when $default != null:
        return $default(
            _that.id,
            _that.areaId,
            _that.userId,
            _that.recipientName,
            _that.recipientPhone,
            _that.streetAddress,
            _that.buildingName,
            _that.streetNumber,
            _that.streetName,
            _that.suburb,
            _that.city,
            _that.postalCode,
            _that.complexName,
            _that.unitNumber,
            _that.floor,
            _that.type,
            _that.province,
            _that.latitude,
            _that.longitude,
            _that.createdAt,
            _that.isPrimary);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Address implements Address {
  _Address(
      {@JsonKey(includeToJson: false) this.id,
      @JsonKey(name: 'area_id') this.areaId,
      @JsonKey(name: 'user_id') this.userId,
      @JsonKey(name: 'recipient_name') required this.recipientName,
      @JsonKey(name: 'recipient_phone') required this.recipientPhone,
      @JsonKey(name: 'street_address') required this.streetAddress,
      @JsonKey(name: 'building_name') this.buildingName,
      @JsonKey(name: 'street_number') this.streetNumber,
      @JsonKey(name: 'street_name') this.streetName,
      this.suburb,
      this.city,
      @JsonKey(name: 'postal_code') this.postalCode,
      @JsonKey(name: 'complex_name') this.complexName,
      @JsonKey(name: 'unit_number') this.unitNumber,
      this.floor,
      required this.type,
      required this.province,
      this.latitude,
      this.longitude,
      @JsonKey(name: 'created_at', includeToJson: false)
      required this.createdAt,
      @JsonKey(name: 'is_primary') this.isPrimary = false});
  factory _Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int? id;
  @override
  @JsonKey(name: 'area_id')
  final int? areaId;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  @JsonKey(name: 'recipient_name')
  final String recipientName;
  @override
  @JsonKey(name: 'recipient_phone')
  final String recipientPhone;
  @override
  @JsonKey(name: 'street_address')
  final String streetAddress;
  @override
  @JsonKey(name: 'building_name')
  final String? buildingName;
  @override
  @JsonKey(name: 'street_number')
  final String? streetNumber;
  @override
  @JsonKey(name: 'street_name')
  final String? streetName;
  @override
  final String? suburb;
  @override
  final String? city;
  @override
  @JsonKey(name: 'postal_code')
  final String? postalCode;
  @override
  @JsonKey(name: 'complex_name')
  final String? complexName;
  @override
  @JsonKey(name: 'unit_number')
  final String? unitNumber;
  @override
  final String? floor;
  @override
  final String type;
  @override
  final String province;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey(name: 'created_at', includeToJson: false)
  final DateTime createdAt;
  @override
  @JsonKey(name: 'is_primary')
  final bool isPrimary;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddressCopyWith<_Address> get copyWith =>
      __$AddressCopyWithImpl<_Address>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AddressToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Address &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.areaId, areaId) || other.areaId == areaId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.recipientName, recipientName) ||
                other.recipientName == recipientName) &&
            (identical(other.recipientPhone, recipientPhone) ||
                other.recipientPhone == recipientPhone) &&
            (identical(other.streetAddress, streetAddress) ||
                other.streetAddress == streetAddress) &&
            (identical(other.buildingName, buildingName) ||
                other.buildingName == buildingName) &&
            (identical(other.streetNumber, streetNumber) ||
                other.streetNumber == streetNumber) &&
            (identical(other.streetName, streetName) ||
                other.streetName == streetName) &&
            (identical(other.suburb, suburb) || other.suburb == suburb) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.complexName, complexName) ||
                other.complexName == complexName) &&
            (identical(other.unitNumber, unitNumber) ||
                other.unitNumber == unitNumber) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.province, province) ||
                other.province == province) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isPrimary, isPrimary) ||
                other.isPrimary == isPrimary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        areaId,
        userId,
        recipientName,
        recipientPhone,
        streetAddress,
        buildingName,
        streetNumber,
        streetName,
        suburb,
        city,
        postalCode,
        complexName,
        unitNumber,
        floor,
        type,
        province,
        latitude,
        longitude,
        createdAt,
        isPrimary
      ]);

  @override
  String toString() {
    return 'Address(id: $id, areaId: $areaId, userId: $userId, recipientName: $recipientName, recipientPhone: $recipientPhone, streetAddress: $streetAddress, buildingName: $buildingName, streetNumber: $streetNumber, streetName: $streetName, suburb: $suburb, city: $city, postalCode: $postalCode, complexName: $complexName, unitNumber: $unitNumber, floor: $floor, type: $type, province: $province, latitude: $latitude, longitude: $longitude, createdAt: $createdAt, isPrimary: $isPrimary)';
  }
}

/// @nodoc
abstract mixin class _$AddressCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$AddressCopyWith(_Address value, $Res Function(_Address) _then) =
      __$AddressCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int? id,
      @JsonKey(name: 'area_id') int? areaId,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'recipient_name') String recipientName,
      @JsonKey(name: 'recipient_phone') String recipientPhone,
      @JsonKey(name: 'street_address') String streetAddress,
      @JsonKey(name: 'building_name') String? buildingName,
      @JsonKey(name: 'street_number') String? streetNumber,
      @JsonKey(name: 'street_name') String? streetName,
      String? suburb,
      String? city,
      @JsonKey(name: 'postal_code') String? postalCode,
      @JsonKey(name: 'complex_name') String? complexName,
      @JsonKey(name: 'unit_number') String? unitNumber,
      String? floor,
      String type,
      String province,
      double? latitude,
      double? longitude,
      @JsonKey(name: 'created_at', includeToJson: false) DateTime createdAt,
      @JsonKey(name: 'is_primary') bool isPrimary});
}

/// @nodoc
class __$AddressCopyWithImpl<$Res> implements _$AddressCopyWith<$Res> {
  __$AddressCopyWithImpl(this._self, this._then);

  final _Address _self;
  final $Res Function(_Address) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? areaId = freezed,
    Object? userId = freezed,
    Object? recipientName = null,
    Object? recipientPhone = null,
    Object? streetAddress = null,
    Object? buildingName = freezed,
    Object? streetNumber = freezed,
    Object? streetName = freezed,
    Object? suburb = freezed,
    Object? city = freezed,
    Object? postalCode = freezed,
    Object? complexName = freezed,
    Object? unitNumber = freezed,
    Object? floor = freezed,
    Object? type = null,
    Object? province = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? createdAt = null,
    Object? isPrimary = null,
  }) {
    return _then(_Address(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      areaId: freezed == areaId
          ? _self.areaId
          : areaId // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      recipientName: null == recipientName
          ? _self.recipientName
          : recipientName // ignore: cast_nullable_to_non_nullable
              as String,
      recipientPhone: null == recipientPhone
          ? _self.recipientPhone
          : recipientPhone // ignore: cast_nullable_to_non_nullable
              as String,
      streetAddress: null == streetAddress
          ? _self.streetAddress
          : streetAddress // ignore: cast_nullable_to_non_nullable
              as String,
      buildingName: freezed == buildingName
          ? _self.buildingName
          : buildingName // ignore: cast_nullable_to_non_nullable
              as String?,
      streetNumber: freezed == streetNumber
          ? _self.streetNumber
          : streetNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      streetName: freezed == streetName
          ? _self.streetName
          : streetName // ignore: cast_nullable_to_non_nullable
              as String?,
      suburb: freezed == suburb
          ? _self.suburb
          : suburb // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: freezed == postalCode
          ? _self.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      complexName: freezed == complexName
          ? _self.complexName
          : complexName // ignore: cast_nullable_to_non_nullable
              as String?,
      unitNumber: freezed == unitNumber
          ? _self.unitNumber
          : unitNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      floor: freezed == floor
          ? _self.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      province: null == province
          ? _self.province
          : province // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: freezed == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isPrimary: null == isPrimary
          ? _self.isPrimary
          : isPrimary // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
