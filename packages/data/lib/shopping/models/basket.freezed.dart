// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'basket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Basket _$BasketFromJson(Map<String, dynamic> json) {
  return _Basket.fromJson(json);
}

/// @nodoc
mixin _$Basket {
  @JsonKey(includeToJson: false)
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @BasketTypeConverter()
  BasketType? get type => throw _privateConstructorUsedError;

  /// Serializes this Basket to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Basket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BasketCopyWith<Basket> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BasketCopyWith<$Res> {
  factory $BasketCopyWith(Basket value, $Res Function(Basket) then) =
      _$BasketCopyWithImpl<$Res, Basket>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String id,
      String name,
      @BasketTypeConverter() BasketType? type});
}

/// @nodoc
class _$BasketCopyWithImpl<$Res, $Val extends Basket>
    implements $BasketCopyWith<$Res> {
  _$BasketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Basket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BasketType?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BasketImplCopyWith<$Res> implements $BasketCopyWith<$Res> {
  factory _$$BasketImplCopyWith(
          _$BasketImpl value, $Res Function(_$BasketImpl) then) =
      __$$BasketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String id,
      String name,
      @BasketTypeConverter() BasketType? type});
}

/// @nodoc
class __$$BasketImplCopyWithImpl<$Res>
    extends _$BasketCopyWithImpl<$Res, _$BasketImpl>
    implements _$$BasketImplCopyWith<$Res> {
  __$$BasketImplCopyWithImpl(
      _$BasketImpl _value, $Res Function(_$BasketImpl) _then)
      : super(_value, _then);

  /// Create a copy of Basket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = freezed,
  }) {
    return _then(_$BasketImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BasketType?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BasketImpl implements _Basket {
  const _$BasketImpl(
      {@JsonKey(includeToJson: false) required this.id,
      required this.name,
      @BasketTypeConverter() this.type});

  factory _$BasketImpl.fromJson(Map<String, dynamic> json) =>
      _$$BasketImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final String id;
  @override
  final String name;
  @override
  @BasketTypeConverter()
  final BasketType? type;

  @override
  String toString() {
    return 'Basket(id: $id, name: $name, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BasketImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, type);

  /// Create a copy of Basket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BasketImplCopyWith<_$BasketImpl> get copyWith =>
      __$$BasketImplCopyWithImpl<_$BasketImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BasketImplToJson(
      this,
    );
  }
}

abstract class _Basket implements Basket {
  const factory _Basket(
      {@JsonKey(includeToJson: false) required final String id,
      required final String name,
      @BasketTypeConverter() final BasketType? type}) = _$BasketImpl;

  factory _Basket.fromJson(Map<String, dynamic> json) = _$BasketImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  String get id;
  @override
  String get name;
  @override
  @BasketTypeConverter()
  BasketType? get type;

  /// Create a copy of Basket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BasketImplCopyWith<_$BasketImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
