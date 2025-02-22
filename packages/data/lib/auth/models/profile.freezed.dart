// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return _Profile.fromJson(json);
}

/// @nodoc
mixin _$Profile {
  @JsonKey(name: 'user_id', includeToJson: false)
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'rsa_id_number')
  String? get rsaIdNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String? get lastName => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  String? get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool? get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'deactivated_on')
  DateTime? get deactivatedOn => throw _privateConstructorUsedError;
  @JsonKey(name: 'accepted_ts_and_cs')
  bool? get acceptedTsAndCs => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  @UserRoleConverter()
  UserRole get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'corp_name')
  String? get corpName => throw _privateConstructorUsedError;
  @JsonKey(name: 'npc_reg')
  String? get npcReg => throw _privateConstructorUsedError;
  @JsonKey(name: 'corp_reg')
  String? get corpReg => throw _privateConstructorUsedError;
  @JsonKey(name: 'corp_address_id')
  int? get corpAddressId => throw _privateConstructorUsedError;
  @JsonKey(name: 'corp_vat_no')
  String? get corpVatNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_approved', includeToJson: false)
  bool? get isApproved => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'referral_code', includeToJson: false)
  int? get referralCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_verified', includeToJson: false)
  bool get isVerified => throw _privateConstructorUsedError;
  @JsonKey(name: 'foreigner', includeToJson: true)
  bool? get foreigner => throw _privateConstructorUsedError;

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileCopyWith<Profile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileCopyWith<$Res> {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) then) =
      _$ProfileCopyWithImpl<$Res, Profile>;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id', includeToJson: false) String userId,
      @JsonKey(name: 'rsa_id_number') String? rsaIdNumber,
      @JsonKey(name: 'first_name') String? firstName,
      @JsonKey(name: 'last_name') String? lastName,
      @JsonKey(includeToJson: false) String? email,
      @JsonKey(includeToJson: false) String? phone,
      @JsonKey(name: 'is_active') bool? isActive,
      @JsonKey(name: 'deactivated_on') DateTime? deactivatedOn,
      @JsonKey(name: 'accepted_ts_and_cs') bool? acceptedTsAndCs,
      @JsonKey(includeToJson: false) @UserRoleConverter() UserRole role,
      @JsonKey(name: 'corp_name') String? corpName,
      @JsonKey(name: 'npc_reg') String? npcReg,
      @JsonKey(name: 'corp_reg') String? corpReg,
      @JsonKey(name: 'corp_address_id') int? corpAddressId,
      @JsonKey(name: 'corp_vat_no') String? corpVatNo,
      @JsonKey(name: 'is_approved', includeToJson: false) bool? isApproved,
      @JsonKey(name: 'created_at', includeToJson: false) DateTime? createdAt,
      @JsonKey(name: 'referral_code', includeToJson: false) int? referralCode,
      @JsonKey(name: 'is_verified', includeToJson: false) bool isVerified,
      @JsonKey(name: 'foreigner', includeToJson: true) bool? foreigner});
}

/// @nodoc
class _$ProfileCopyWithImpl<$Res, $Val extends Profile>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? rsaIdNumber = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? isActive = freezed,
    Object? deactivatedOn = freezed,
    Object? acceptedTsAndCs = freezed,
    Object? role = null,
    Object? corpName = freezed,
    Object? npcReg = freezed,
    Object? corpReg = freezed,
    Object? corpAddressId = freezed,
    Object? corpVatNo = freezed,
    Object? isApproved = freezed,
    Object? createdAt = freezed,
    Object? referralCode = freezed,
    Object? isVerified = null,
    Object? foreigner = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      rsaIdNumber: freezed == rsaIdNumber
          ? _value.rsaIdNumber
          : rsaIdNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      deactivatedOn: freezed == deactivatedOn
          ? _value.deactivatedOn
          : deactivatedOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      acceptedTsAndCs: freezed == acceptedTsAndCs
          ? _value.acceptedTsAndCs
          : acceptedTsAndCs // ignore: cast_nullable_to_non_nullable
              as bool?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      corpName: freezed == corpName
          ? _value.corpName
          : corpName // ignore: cast_nullable_to_non_nullable
              as String?,
      npcReg: freezed == npcReg
          ? _value.npcReg
          : npcReg // ignore: cast_nullable_to_non_nullable
              as String?,
      corpReg: freezed == corpReg
          ? _value.corpReg
          : corpReg // ignore: cast_nullable_to_non_nullable
              as String?,
      corpAddressId: freezed == corpAddressId
          ? _value.corpAddressId
          : corpAddressId // ignore: cast_nullable_to_non_nullable
              as int?,
      corpVatNo: freezed == corpVatNo
          ? _value.corpVatNo
          : corpVatNo // ignore: cast_nullable_to_non_nullable
              as String?,
      isApproved: freezed == isApproved
          ? _value.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      referralCode: freezed == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as int?,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      foreigner: freezed == foreigner
          ? _value.foreigner
          : foreigner // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileImplCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$$ProfileImplCopyWith(
          _$ProfileImpl value, $Res Function(_$ProfileImpl) then) =
      __$$ProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id', includeToJson: false) String userId,
      @JsonKey(name: 'rsa_id_number') String? rsaIdNumber,
      @JsonKey(name: 'first_name') String? firstName,
      @JsonKey(name: 'last_name') String? lastName,
      @JsonKey(includeToJson: false) String? email,
      @JsonKey(includeToJson: false) String? phone,
      @JsonKey(name: 'is_active') bool? isActive,
      @JsonKey(name: 'deactivated_on') DateTime? deactivatedOn,
      @JsonKey(name: 'accepted_ts_and_cs') bool? acceptedTsAndCs,
      @JsonKey(includeToJson: false) @UserRoleConverter() UserRole role,
      @JsonKey(name: 'corp_name') String? corpName,
      @JsonKey(name: 'npc_reg') String? npcReg,
      @JsonKey(name: 'corp_reg') String? corpReg,
      @JsonKey(name: 'corp_address_id') int? corpAddressId,
      @JsonKey(name: 'corp_vat_no') String? corpVatNo,
      @JsonKey(name: 'is_approved', includeToJson: false) bool? isApproved,
      @JsonKey(name: 'created_at', includeToJson: false) DateTime? createdAt,
      @JsonKey(name: 'referral_code', includeToJson: false) int? referralCode,
      @JsonKey(name: 'is_verified', includeToJson: false) bool isVerified,
      @JsonKey(name: 'foreigner', includeToJson: true) bool? foreigner});
}

/// @nodoc
class __$$ProfileImplCopyWithImpl<$Res>
    extends _$ProfileCopyWithImpl<$Res, _$ProfileImpl>
    implements _$$ProfileImplCopyWith<$Res> {
  __$$ProfileImplCopyWithImpl(
      _$ProfileImpl _value, $Res Function(_$ProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? rsaIdNumber = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? isActive = freezed,
    Object? deactivatedOn = freezed,
    Object? acceptedTsAndCs = freezed,
    Object? role = null,
    Object? corpName = freezed,
    Object? npcReg = freezed,
    Object? corpReg = freezed,
    Object? corpAddressId = freezed,
    Object? corpVatNo = freezed,
    Object? isApproved = freezed,
    Object? createdAt = freezed,
    Object? referralCode = freezed,
    Object? isVerified = null,
    Object? foreigner = freezed,
  }) {
    return _then(_$ProfileImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      rsaIdNumber: freezed == rsaIdNumber
          ? _value.rsaIdNumber
          : rsaIdNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      deactivatedOn: freezed == deactivatedOn
          ? _value.deactivatedOn
          : deactivatedOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      acceptedTsAndCs: freezed == acceptedTsAndCs
          ? _value.acceptedTsAndCs
          : acceptedTsAndCs // ignore: cast_nullable_to_non_nullable
              as bool?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      corpName: freezed == corpName
          ? _value.corpName
          : corpName // ignore: cast_nullable_to_non_nullable
              as String?,
      npcReg: freezed == npcReg
          ? _value.npcReg
          : npcReg // ignore: cast_nullable_to_non_nullable
              as String?,
      corpReg: freezed == corpReg
          ? _value.corpReg
          : corpReg // ignore: cast_nullable_to_non_nullable
              as String?,
      corpAddressId: freezed == corpAddressId
          ? _value.corpAddressId
          : corpAddressId // ignore: cast_nullable_to_non_nullable
              as int?,
      corpVatNo: freezed == corpVatNo
          ? _value.corpVatNo
          : corpVatNo // ignore: cast_nullable_to_non_nullable
              as String?,
      isApproved: freezed == isApproved
          ? _value.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      referralCode: freezed == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as int?,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      foreigner: freezed == foreigner
          ? _value.foreigner
          : foreigner // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileImpl implements _Profile {
  const _$ProfileImpl(
      {@JsonKey(name: 'user_id', includeToJson: false) required this.userId,
      @JsonKey(name: 'rsa_id_number') this.rsaIdNumber,
      @JsonKey(name: 'first_name') this.firstName,
      @JsonKey(name: 'last_name') this.lastName,
      @JsonKey(includeToJson: false) this.email,
      @JsonKey(includeToJson: false) this.phone,
      @JsonKey(name: 'is_active') this.isActive,
      @JsonKey(name: 'deactivated_on') this.deactivatedOn,
      @JsonKey(name: 'accepted_ts_and_cs') this.acceptedTsAndCs,
      @JsonKey(includeToJson: false) @UserRoleConverter() required this.role,
      @JsonKey(name: 'corp_name') this.corpName,
      @JsonKey(name: 'npc_reg') this.npcReg,
      @JsonKey(name: 'corp_reg') this.corpReg,
      @JsonKey(name: 'corp_address_id') this.corpAddressId,
      @JsonKey(name: 'corp_vat_no') this.corpVatNo,
      @JsonKey(name: 'is_approved', includeToJson: false) this.isApproved,
      @JsonKey(name: 'created_at', includeToJson: false) this.createdAt,
      @JsonKey(name: 'referral_code', includeToJson: false) this.referralCode,
      @JsonKey(name: 'is_verified', includeToJson: false)
      required this.isVerified,
      @JsonKey(name: 'foreigner', includeToJson: true) this.foreigner});

  factory _$ProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileImplFromJson(json);

  @override
  @JsonKey(name: 'user_id', includeToJson: false)
  final String userId;
  @override
  @JsonKey(name: 'rsa_id_number')
  final String? rsaIdNumber;
  @override
  @JsonKey(name: 'first_name')
  final String? firstName;
  @override
  @JsonKey(name: 'last_name')
  final String? lastName;
  @override
  @JsonKey(includeToJson: false)
  final String? email;
  @override
  @JsonKey(includeToJson: false)
  final String? phone;
  @override
  @JsonKey(name: 'is_active')
  final bool? isActive;
  @override
  @JsonKey(name: 'deactivated_on')
  final DateTime? deactivatedOn;
  @override
  @JsonKey(name: 'accepted_ts_and_cs')
  final bool? acceptedTsAndCs;
  @override
  @JsonKey(includeToJson: false)
  @UserRoleConverter()
  final UserRole role;
  @override
  @JsonKey(name: 'corp_name')
  final String? corpName;
  @override
  @JsonKey(name: 'npc_reg')
  final String? npcReg;
  @override
  @JsonKey(name: 'corp_reg')
  final String? corpReg;
  @override
  @JsonKey(name: 'corp_address_id')
  final int? corpAddressId;
  @override
  @JsonKey(name: 'corp_vat_no')
  final String? corpVatNo;
  @override
  @JsonKey(name: 'is_approved', includeToJson: false)
  final bool? isApproved;
  @override
  @JsonKey(name: 'created_at', includeToJson: false)
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'referral_code', includeToJson: false)
  final int? referralCode;
  @override
  @JsonKey(name: 'is_verified', includeToJson: false)
  final bool isVerified;
  @override
  @JsonKey(name: 'foreigner', includeToJson: true)
  final bool? foreigner;

  @override
  String toString() {
    return 'Profile(userId: $userId, rsaIdNumber: $rsaIdNumber, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, isActive: $isActive, deactivatedOn: $deactivatedOn, acceptedTsAndCs: $acceptedTsAndCs, role: $role, corpName: $corpName, npcReg: $npcReg, corpReg: $corpReg, corpAddressId: $corpAddressId, corpVatNo: $corpVatNo, isApproved: $isApproved, createdAt: $createdAt, referralCode: $referralCode, isVerified: $isVerified, foreigner: $foreigner)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.rsaIdNumber, rsaIdNumber) ||
                other.rsaIdNumber == rsaIdNumber) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.deactivatedOn, deactivatedOn) ||
                other.deactivatedOn == deactivatedOn) &&
            (identical(other.acceptedTsAndCs, acceptedTsAndCs) ||
                other.acceptedTsAndCs == acceptedTsAndCs) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.corpName, corpName) ||
                other.corpName == corpName) &&
            (identical(other.npcReg, npcReg) || other.npcReg == npcReg) &&
            (identical(other.corpReg, corpReg) || other.corpReg == corpReg) &&
            (identical(other.corpAddressId, corpAddressId) ||
                other.corpAddressId == corpAddressId) &&
            (identical(other.corpVatNo, corpVatNo) ||
                other.corpVatNo == corpVatNo) &&
            (identical(other.isApproved, isApproved) ||
                other.isApproved == isApproved) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.foreigner, foreigner) ||
                other.foreigner == foreigner));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        userId,
        rsaIdNumber,
        firstName,
        lastName,
        email,
        phone,
        isActive,
        deactivatedOn,
        acceptedTsAndCs,
        role,
        corpName,
        npcReg,
        corpReg,
        corpAddressId,
        corpVatNo,
        isApproved,
        createdAt,
        referralCode,
        isVerified,
        foreigner
      ]);

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      __$$ProfileImplCopyWithImpl<_$ProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileImplToJson(
      this,
    );
  }
}

abstract class _Profile implements Profile {
  const factory _Profile(
      {@JsonKey(name: 'user_id', includeToJson: false)
      required final String userId,
      @JsonKey(name: 'rsa_id_number') final String? rsaIdNumber,
      @JsonKey(name: 'first_name') final String? firstName,
      @JsonKey(name: 'last_name') final String? lastName,
      @JsonKey(includeToJson: false) final String? email,
      @JsonKey(includeToJson: false) final String? phone,
      @JsonKey(name: 'is_active') final bool? isActive,
      @JsonKey(name: 'deactivated_on') final DateTime? deactivatedOn,
      @JsonKey(name: 'accepted_ts_and_cs') final bool? acceptedTsAndCs,
      @JsonKey(includeToJson: false)
      @UserRoleConverter()
      required final UserRole role,
      @JsonKey(name: 'corp_name') final String? corpName,
      @JsonKey(name: 'npc_reg') final String? npcReg,
      @JsonKey(name: 'corp_reg') final String? corpReg,
      @JsonKey(name: 'corp_address_id') final int? corpAddressId,
      @JsonKey(name: 'corp_vat_no') final String? corpVatNo,
      @JsonKey(name: 'is_approved', includeToJson: false)
      final bool? isApproved,
      @JsonKey(name: 'created_at', includeToJson: false)
      final DateTime? createdAt,
      @JsonKey(name: 'referral_code', includeToJson: false)
      final int? referralCode,
      @JsonKey(name: 'is_verified', includeToJson: false)
      required final bool isVerified,
      @JsonKey(name: 'foreigner', includeToJson: true)
      final bool? foreigner}) = _$ProfileImpl;

  factory _Profile.fromJson(Map<String, dynamic> json) = _$ProfileImpl.fromJson;

  @override
  @JsonKey(name: 'user_id', includeToJson: false)
  String get userId;
  @override
  @JsonKey(name: 'rsa_id_number')
  String? get rsaIdNumber;
  @override
  @JsonKey(name: 'first_name')
  String? get firstName;
  @override
  @JsonKey(name: 'last_name')
  String? get lastName;
  @override
  @JsonKey(includeToJson: false)
  String? get email;
  @override
  @JsonKey(includeToJson: false)
  String? get phone;
  @override
  @JsonKey(name: 'is_active')
  bool? get isActive;
  @override
  @JsonKey(name: 'deactivated_on')
  DateTime? get deactivatedOn;
  @override
  @JsonKey(name: 'accepted_ts_and_cs')
  bool? get acceptedTsAndCs;
  @override
  @JsonKey(includeToJson: false)
  @UserRoleConverter()
  UserRole get role;
  @override
  @JsonKey(name: 'corp_name')
  String? get corpName;
  @override
  @JsonKey(name: 'npc_reg')
  String? get npcReg;
  @override
  @JsonKey(name: 'corp_reg')
  String? get corpReg;
  @override
  @JsonKey(name: 'corp_address_id')
  int? get corpAddressId;
  @override
  @JsonKey(name: 'corp_vat_no')
  String? get corpVatNo;
  @override
  @JsonKey(name: 'is_approved', includeToJson: false)
  bool? get isApproved;
  @override
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'referral_code', includeToJson: false)
  int? get referralCode;
  @override
  @JsonKey(name: 'is_verified', includeToJson: false)
  bool get isVerified;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(ignore: true)
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
