// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'basket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Basket {
  @JsonKey(includeToJson: false)
  String get id;
  String get name;
  @BasketTypeConverter()
  BasketType? get type;

  /// Create a copy of Basket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BasketCopyWith<Basket> get copyWith =>
      _$BasketCopyWithImpl<Basket>(this as Basket, _$identity);

  /// Serializes this Basket to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Basket &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, type);

  @override
  String toString() {
    return 'Basket(id: $id, name: $name, type: $type)';
  }
}

/// @nodoc
abstract mixin class $BasketCopyWith<$Res> {
  factory $BasketCopyWith(Basket value, $Res Function(Basket) _then) =
      _$BasketCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String id,
      String name,
      @BasketTypeConverter() BasketType? type});
}

/// @nodoc
class _$BasketCopyWithImpl<$Res> implements $BasketCopyWith<$Res> {
  _$BasketCopyWithImpl(this._self, this._then);

  final Basket _self;
  final $Res Function(Basket) _then;

  /// Create a copy of Basket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as BasketType?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Basket implements Basket {
  const _Basket(
      {@JsonKey(includeToJson: false) required this.id,
      required this.name,
      @BasketTypeConverter() this.type});
  factory _Basket.fromJson(Map<String, dynamic> json) => _$BasketFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final String id;
  @override
  final String name;
  @override
  @BasketTypeConverter()
  final BasketType? type;

  /// Create a copy of Basket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BasketCopyWith<_Basket> get copyWith =>
      __$BasketCopyWithImpl<_Basket>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BasketToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Basket &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, type);

  @override
  String toString() {
    return 'Basket(id: $id, name: $name, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$BasketCopyWith<$Res> implements $BasketCopyWith<$Res> {
  factory _$BasketCopyWith(_Basket value, $Res Function(_Basket) _then) =
      __$BasketCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String id,
      String name,
      @BasketTypeConverter() BasketType? type});
}

/// @nodoc
class __$BasketCopyWithImpl<$Res> implements _$BasketCopyWith<$Res> {
  __$BasketCopyWithImpl(this._self, this._then);

  final _Basket _self;
  final $Res Function(_Basket) _then;

  /// Create a copy of Basket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = freezed,
  }) {
    return _then(_Basket(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as BasketType?,
    ));
  }
}

// dart format on
