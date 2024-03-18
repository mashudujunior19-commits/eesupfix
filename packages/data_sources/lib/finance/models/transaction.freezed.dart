// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return _Transaction.fromJson(json);
}

/// @nodoc
mixin _$Transaction {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'doc_ref')
  int get docRef => throw _privateConstructorUsedError;
  @JsonKey(name: 'value')
  double get value => throw _privateConstructorUsedError;
  @JsonKey(name: 'vested')
  bool get vested => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'confirmed_at')
  DateTime? get confirmedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'cancelled_at')
  DateTime? get cancelledAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) then) =
      _$TransactionCopyWithImpl<$Res, Transaction>;
  @useResult
  $Res call(
      {int id,
      String type,
      @JsonKey(name: 'doc_ref') int docRef,
      @JsonKey(name: 'value') double value,
      @JsonKey(name: 'vested') bool vested,
      @JsonKey(name: 'description') String description,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'confirmed_at') DateTime? confirmedAt,
      @JsonKey(name: 'cancelled_at') DateTime? cancelledAt});
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res, $Val extends Transaction>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? docRef = null,
    Object? value = null,
    Object? vested = null,
    Object? description = null,
    Object? createdAt = null,
    Object? confirmedAt = freezed,
    Object? cancelledAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      docRef: null == docRef
          ? _value.docRef
          : docRef // ignore: cast_nullable_to_non_nullable
              as int,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      vested: null == vested
          ? _value.vested
          : vested // ignore: cast_nullable_to_non_nullable
              as bool,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      confirmedAt: freezed == confirmedAt
          ? _value.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionImplCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$TransactionImplCopyWith(
          _$TransactionImpl value, $Res Function(_$TransactionImpl) then) =
      __$$TransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String type,
      @JsonKey(name: 'doc_ref') int docRef,
      @JsonKey(name: 'value') double value,
      @JsonKey(name: 'vested') bool vested,
      @JsonKey(name: 'description') String description,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'confirmed_at') DateTime? confirmedAt,
      @JsonKey(name: 'cancelled_at') DateTime? cancelledAt});
}

/// @nodoc
class __$$TransactionImplCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$TransactionImpl>
    implements _$$TransactionImplCopyWith<$Res> {
  __$$TransactionImplCopyWithImpl(
      _$TransactionImpl _value, $Res Function(_$TransactionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? docRef = null,
    Object? value = null,
    Object? vested = null,
    Object? description = null,
    Object? createdAt = null,
    Object? confirmedAt = freezed,
    Object? cancelledAt = freezed,
  }) {
    return _then(_$TransactionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      docRef: null == docRef
          ? _value.docRef
          : docRef // ignore: cast_nullable_to_non_nullable
              as int,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      vested: null == vested
          ? _value.vested
          : vested // ignore: cast_nullable_to_non_nullable
              as bool,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      confirmedAt: freezed == confirmedAt
          ? _value.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionImpl with DiagnosticableTreeMixin implements _Transaction {
  const _$TransactionImpl(
      {required this.id,
      required this.type,
      @JsonKey(name: 'doc_ref') required this.docRef,
      @JsonKey(name: 'value') required this.value,
      @JsonKey(name: 'vested') required this.vested,
      @JsonKey(name: 'description') required this.description,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'confirmed_at') this.confirmedAt,
      @JsonKey(name: 'cancelled_at') this.cancelledAt});

  factory _$TransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionImplFromJson(json);

  @override
  final int id;
  @override
  final String type;
  @override
  @JsonKey(name: 'doc_ref')
  final int docRef;
  @override
  @JsonKey(name: 'value')
  final double value;
  @override
  @JsonKey(name: 'vested')
  final bool vested;
  @override
  @JsonKey(name: 'description')
  final String description;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'confirmed_at')
  final DateTime? confirmedAt;
  @override
  @JsonKey(name: 'cancelled_at')
  final DateTime? cancelledAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Transaction(id: $id, type: $type, docRef: $docRef, value: $value, vested: $vested, description: $description, createdAt: $createdAt, confirmedAt: $confirmedAt, cancelledAt: $cancelledAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Transaction'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('docRef', docRef))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('vested', vested))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('confirmedAt', confirmedAt))
      ..add(DiagnosticsProperty('cancelledAt', cancelledAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.docRef, docRef) || other.docRef == docRef) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.vested, vested) || other.vested == vested) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.confirmedAt, confirmedAt) ||
                other.confirmedAt == confirmedAt) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, docRef, value, vested,
      description, createdAt, confirmedAt, cancelledAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      __$$TransactionImplCopyWithImpl<_$TransactionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionImplToJson(
      this,
    );
  }
}

abstract class _Transaction implements Transaction {
  const factory _Transaction(
          {required final int id,
          required final String type,
          @JsonKey(name: 'doc_ref') required final int docRef,
          @JsonKey(name: 'value') required final double value,
          @JsonKey(name: 'vested') required final bool vested,
          @JsonKey(name: 'description') required final String description,
          @JsonKey(name: 'created_at') required final DateTime createdAt,
          @JsonKey(name: 'confirmed_at') final DateTime? confirmedAt,
          @JsonKey(name: 'cancelled_at') final DateTime? cancelledAt}) =
      _$TransactionImpl;

  factory _Transaction.fromJson(Map<String, dynamic> json) =
      _$TransactionImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(name: 'doc_ref')
  int get docRef;
  @override
  @JsonKey(name: 'value')
  double get value;
  @override
  @JsonKey(name: 'vested')
  bool get vested;
  @override
  @JsonKey(name: 'description')
  String get description;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'confirmed_at')
  DateTime? get confirmedAt;
  @override
  @JsonKey(name: 'cancelled_at')
  DateTime? get cancelledAt;
  @override
  @JsonKey(ignore: true)
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
