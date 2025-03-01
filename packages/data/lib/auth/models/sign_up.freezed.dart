// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignUp {
  String? get email;
  String? get phone;
  String get password;
  UserRole? get role;
  String? get firstName;
  String? get lastName;
  int? get referralCode;
  bool? get isCorp;
  String? get idNumber;
  String? get corpName;
  String? get corpReg;
  String? get npcReg;
  bool get isAgreed;
  bool get isRSACitizen;
  DateTime? get dob;

  /// Create a copy of SignUp
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignUpCopyWith<SignUp> get copyWith =>
      _$SignUpCopyWithImpl<SignUp>(this as SignUp, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignUp &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode) &&
            (identical(other.isCorp, isCorp) || other.isCorp == isCorp) &&
            (identical(other.idNumber, idNumber) ||
                other.idNumber == idNumber) &&
            (identical(other.corpName, corpName) ||
                other.corpName == corpName) &&
            (identical(other.corpReg, corpReg) || other.corpReg == corpReg) &&
            (identical(other.npcReg, npcReg) || other.npcReg == npcReg) &&
            (identical(other.isAgreed, isAgreed) ||
                other.isAgreed == isAgreed) &&
            (identical(other.isRSACitizen, isRSACitizen) ||
                other.isRSACitizen == isRSACitizen) &&
            (identical(other.dob, dob) || other.dob == dob));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      email,
      phone,
      password,
      role,
      firstName,
      lastName,
      referralCode,
      isCorp,
      idNumber,
      corpName,
      corpReg,
      npcReg,
      isAgreed,
      isRSACitizen,
      dob);

  @override
  String toString() {
    return 'SignUp(email: $email, phone: $phone, password: $password, role: $role, firstName: $firstName, lastName: $lastName, referralCode: $referralCode, isCorp: $isCorp, idNumber: $idNumber, corpName: $corpName, corpReg: $corpReg, npcReg: $npcReg, isAgreed: $isAgreed, isRSACitizen: $isRSACitizen, dob: $dob)';
  }
}

/// @nodoc
abstract mixin class $SignUpCopyWith<$Res> {
  factory $SignUpCopyWith(SignUp value, $Res Function(SignUp) _then) =
      _$SignUpCopyWithImpl;
  @useResult
  $Res call(
      {String? email,
      String? phone,
      String password,
      UserRole? role,
      String? firstName,
      String? lastName,
      int? referralCode,
      bool? isCorp,
      String? idNumber,
      String? corpName,
      String? corpReg,
      String? npcReg,
      bool isAgreed,
      bool isRSACitizen,
      DateTime? dob});
}

/// @nodoc
class _$SignUpCopyWithImpl<$Res> implements $SignUpCopyWith<$Res> {
  _$SignUpCopyWithImpl(this._self, this._then);

  final SignUp _self;
  final $Res Function(SignUp) _then;

  /// Create a copy of SignUp
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? phone = freezed,
    Object? password = null,
    Object? role = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? referralCode = freezed,
    Object? isCorp = freezed,
    Object? idNumber = freezed,
    Object? corpName = freezed,
    Object? corpReg = freezed,
    Object? npcReg = freezed,
    Object? isAgreed = null,
    Object? isRSACitizen = null,
    Object? dob = freezed,
  }) {
    return _then(_self.copyWith(
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      role: freezed == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole?,
      firstName: freezed == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      referralCode: freezed == referralCode
          ? _self.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as int?,
      isCorp: freezed == isCorp
          ? _self.isCorp
          : isCorp // ignore: cast_nullable_to_non_nullable
              as bool?,
      idNumber: freezed == idNumber
          ? _self.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      corpName: freezed == corpName
          ? _self.corpName
          : corpName // ignore: cast_nullable_to_non_nullable
              as String?,
      corpReg: freezed == corpReg
          ? _self.corpReg
          : corpReg // ignore: cast_nullable_to_non_nullable
              as String?,
      npcReg: freezed == npcReg
          ? _self.npcReg
          : npcReg // ignore: cast_nullable_to_non_nullable
              as String?,
      isAgreed: null == isAgreed
          ? _self.isAgreed
          : isAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isRSACitizen: null == isRSACitizen
          ? _self.isRSACitizen
          : isRSACitizen // ignore: cast_nullable_to_non_nullable
              as bool,
      dob: freezed == dob
          ? _self.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _SignUp implements SignUp {
  const _SignUp(
      {this.email,
      this.phone,
      required this.password,
      required this.role,
      this.firstName,
      this.lastName,
      this.referralCode,
      required this.isCorp,
      this.idNumber,
      this.corpName,
      this.corpReg,
      this.npcReg,
      required this.isAgreed,
      required this.isRSACitizen,
      this.dob});

  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String password;
  @override
  final UserRole? role;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final int? referralCode;
  @override
  final bool? isCorp;
  @override
  final String? idNumber;
  @override
  final String? corpName;
  @override
  final String? corpReg;
  @override
  final String? npcReg;
  @override
  final bool isAgreed;
  @override
  final bool isRSACitizen;
  @override
  final DateTime? dob;

  /// Create a copy of SignUp
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SignUpCopyWith<_SignUp> get copyWith =>
      __$SignUpCopyWithImpl<_SignUp>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignUp &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode) &&
            (identical(other.isCorp, isCorp) || other.isCorp == isCorp) &&
            (identical(other.idNumber, idNumber) ||
                other.idNumber == idNumber) &&
            (identical(other.corpName, corpName) ||
                other.corpName == corpName) &&
            (identical(other.corpReg, corpReg) || other.corpReg == corpReg) &&
            (identical(other.npcReg, npcReg) || other.npcReg == npcReg) &&
            (identical(other.isAgreed, isAgreed) ||
                other.isAgreed == isAgreed) &&
            (identical(other.isRSACitizen, isRSACitizen) ||
                other.isRSACitizen == isRSACitizen) &&
            (identical(other.dob, dob) || other.dob == dob));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      email,
      phone,
      password,
      role,
      firstName,
      lastName,
      referralCode,
      isCorp,
      idNumber,
      corpName,
      corpReg,
      npcReg,
      isAgreed,
      isRSACitizen,
      dob);

  @override
  String toString() {
    return 'SignUp(email: $email, phone: $phone, password: $password, role: $role, firstName: $firstName, lastName: $lastName, referralCode: $referralCode, isCorp: $isCorp, idNumber: $idNumber, corpName: $corpName, corpReg: $corpReg, npcReg: $npcReg, isAgreed: $isAgreed, isRSACitizen: $isRSACitizen, dob: $dob)';
  }
}

/// @nodoc
abstract mixin class _$SignUpCopyWith<$Res> implements $SignUpCopyWith<$Res> {
  factory _$SignUpCopyWith(_SignUp value, $Res Function(_SignUp) _then) =
      __$SignUpCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? email,
      String? phone,
      String password,
      UserRole? role,
      String? firstName,
      String? lastName,
      int? referralCode,
      bool? isCorp,
      String? idNumber,
      String? corpName,
      String? corpReg,
      String? npcReg,
      bool isAgreed,
      bool isRSACitizen,
      DateTime? dob});
}

/// @nodoc
class __$SignUpCopyWithImpl<$Res> implements _$SignUpCopyWith<$Res> {
  __$SignUpCopyWithImpl(this._self, this._then);

  final _SignUp _self;
  final $Res Function(_SignUp) _then;

  /// Create a copy of SignUp
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? email = freezed,
    Object? phone = freezed,
    Object? password = null,
    Object? role = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? referralCode = freezed,
    Object? isCorp = freezed,
    Object? idNumber = freezed,
    Object? corpName = freezed,
    Object? corpReg = freezed,
    Object? npcReg = freezed,
    Object? isAgreed = null,
    Object? isRSACitizen = null,
    Object? dob = freezed,
  }) {
    return _then(_SignUp(
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      role: freezed == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole?,
      firstName: freezed == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      referralCode: freezed == referralCode
          ? _self.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as int?,
      isCorp: freezed == isCorp
          ? _self.isCorp
          : isCorp // ignore: cast_nullable_to_non_nullable
              as bool?,
      idNumber: freezed == idNumber
          ? _self.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      corpName: freezed == corpName
          ? _self.corpName
          : corpName // ignore: cast_nullable_to_non_nullable
              as String?,
      corpReg: freezed == corpReg
          ? _self.corpReg
          : corpReg // ignore: cast_nullable_to_non_nullable
              as String?,
      npcReg: freezed == npcReg
          ? _self.npcReg
          : npcReg // ignore: cast_nullable_to_non_nullable
              as String?,
      isAgreed: null == isAgreed
          ? _self.isAgreed
          : isAgreed // ignore: cast_nullable_to_non_nullable
              as bool,
      isRSACitizen: null == isRSACitizen
          ? _self.isRSACitizen
          : isRSACitizen // ignore: cast_nullable_to_non_nullable
              as bool,
      dob: freezed == dob
          ? _self.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
