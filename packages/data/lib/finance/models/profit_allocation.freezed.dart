// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profit_allocation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfitAllocation {
  double get cia;
  double get cwa;
  double get eia;
  double get crc;
  double get csa;
  double get daa;
  int get id;
  double get cfv;

  /// Create a copy of ProfitAllocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProfitAllocationCopyWith<ProfitAllocation> get copyWith =>
      _$ProfitAllocationCopyWithImpl<ProfitAllocation>(
          this as ProfitAllocation, _$identity);

  /// Serializes this ProfitAllocation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProfitAllocation &&
            (identical(other.cia, cia) || other.cia == cia) &&
            (identical(other.cwa, cwa) || other.cwa == cwa) &&
            (identical(other.eia, eia) || other.eia == eia) &&
            (identical(other.crc, crc) || other.crc == crc) &&
            (identical(other.csa, csa) || other.csa == csa) &&
            (identical(other.daa, daa) || other.daa == daa) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.cfv, cfv) || other.cfv == cfv));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, cia, cwa, eia, crc, csa, daa, id, cfv);

  @override
  String toString() {
    return 'ProfitAllocation(cia: $cia, cwa: $cwa, eia: $eia, crc: $crc, csa: $csa, daa: $daa, id: $id, cfv: $cfv)';
  }
}

/// @nodoc
abstract mixin class $ProfitAllocationCopyWith<$Res> {
  factory $ProfitAllocationCopyWith(
          ProfitAllocation value, $Res Function(ProfitAllocation) _then) =
      _$ProfitAllocationCopyWithImpl;
  @useResult
  $Res call(
      {double cia,
      double cwa,
      double eia,
      double crc,
      double csa,
      double daa,
      int id,
      double cfv});
}

/// @nodoc
class _$ProfitAllocationCopyWithImpl<$Res>
    implements $ProfitAllocationCopyWith<$Res> {
  _$ProfitAllocationCopyWithImpl(this._self, this._then);

  final ProfitAllocation _self;
  final $Res Function(ProfitAllocation) _then;

  /// Create a copy of ProfitAllocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cia = null,
    Object? cwa = null,
    Object? eia = null,
    Object? crc = null,
    Object? csa = null,
    Object? daa = null,
    Object? id = null,
    Object? cfv = null,
  }) {
    return _then(_self.copyWith(
      cia: null == cia
          ? _self.cia
          : cia // ignore: cast_nullable_to_non_nullable
              as double,
      cwa: null == cwa
          ? _self.cwa
          : cwa // ignore: cast_nullable_to_non_nullable
              as double,
      eia: null == eia
          ? _self.eia
          : eia // ignore: cast_nullable_to_non_nullable
              as double,
      crc: null == crc
          ? _self.crc
          : crc // ignore: cast_nullable_to_non_nullable
              as double,
      csa: null == csa
          ? _self.csa
          : csa // ignore: cast_nullable_to_non_nullable
              as double,
      daa: null == daa
          ? _self.daa
          : daa // ignore: cast_nullable_to_non_nullable
              as double,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      cfv: null == cfv
          ? _self.cfv
          : cfv // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ProfitAllocation implements ProfitAllocation {
  const _ProfitAllocation(
      {required this.cia,
      required this.cwa,
      required this.eia,
      required this.crc,
      required this.csa,
      required this.daa,
      required this.id,
      required this.cfv});
  factory _ProfitAllocation.fromJson(Map<String, dynamic> json) =>
      _$ProfitAllocationFromJson(json);

  @override
  final double cia;
  @override
  final double cwa;
  @override
  final double eia;
  @override
  final double crc;
  @override
  final double csa;
  @override
  final double daa;
  @override
  final int id;
  @override
  final double cfv;

  /// Create a copy of ProfitAllocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProfitAllocationCopyWith<_ProfitAllocation> get copyWith =>
      __$ProfitAllocationCopyWithImpl<_ProfitAllocation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProfitAllocationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProfitAllocation &&
            (identical(other.cia, cia) || other.cia == cia) &&
            (identical(other.cwa, cwa) || other.cwa == cwa) &&
            (identical(other.eia, eia) || other.eia == eia) &&
            (identical(other.crc, crc) || other.crc == crc) &&
            (identical(other.csa, csa) || other.csa == csa) &&
            (identical(other.daa, daa) || other.daa == daa) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.cfv, cfv) || other.cfv == cfv));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, cia, cwa, eia, crc, csa, daa, id, cfv);

  @override
  String toString() {
    return 'ProfitAllocation(cia: $cia, cwa: $cwa, eia: $eia, crc: $crc, csa: $csa, daa: $daa, id: $id, cfv: $cfv)';
  }
}

/// @nodoc
abstract mixin class _$ProfitAllocationCopyWith<$Res>
    implements $ProfitAllocationCopyWith<$Res> {
  factory _$ProfitAllocationCopyWith(
          _ProfitAllocation value, $Res Function(_ProfitAllocation) _then) =
      __$ProfitAllocationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double cia,
      double cwa,
      double eia,
      double crc,
      double csa,
      double daa,
      int id,
      double cfv});
}

/// @nodoc
class __$ProfitAllocationCopyWithImpl<$Res>
    implements _$ProfitAllocationCopyWith<$Res> {
  __$ProfitAllocationCopyWithImpl(this._self, this._then);

  final _ProfitAllocation _self;
  final $Res Function(_ProfitAllocation) _then;

  /// Create a copy of ProfitAllocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? cia = null,
    Object? cwa = null,
    Object? eia = null,
    Object? crc = null,
    Object? csa = null,
    Object? daa = null,
    Object? id = null,
    Object? cfv = null,
  }) {
    return _then(_ProfitAllocation(
      cia: null == cia
          ? _self.cia
          : cia // ignore: cast_nullable_to_non_nullable
              as double,
      cwa: null == cwa
          ? _self.cwa
          : cwa // ignore: cast_nullable_to_non_nullable
              as double,
      eia: null == eia
          ? _self.eia
          : eia // ignore: cast_nullable_to_non_nullable
              as double,
      crc: null == crc
          ? _self.crc
          : crc // ignore: cast_nullable_to_non_nullable
              as double,
      csa: null == csa
          ? _self.csa
          : csa // ignore: cast_nullable_to_non_nullable
              as double,
      daa: null == daa
          ? _self.daa
          : daa // ignore: cast_nullable_to_non_nullable
              as double,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      cfv: null == cfv
          ? _self.cfv
          : cfv // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
