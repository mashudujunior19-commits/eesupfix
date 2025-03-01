// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Profile {
  @JsonKey(name: 'user_id', includeToJson: false)
  String get userId;
  @JsonKey(name: 'rsa_id_number')
  String? get rsaIdNumber;
  @JsonKey(name: 'first_name')
  String? get firstName;
  @JsonKey(name: 'last_name')
  String? get lastName;
  @JsonKey(includeToJson: false)
  String? get email;
  @JsonKey(includeToJson: false)
  String? get phone;
  @JsonKey(name: 'is_active')
  bool? get isActive;
  @JsonKey(name: 'deactivated_on')
  DateTime? get deactivatedOn;
  @JsonKey(name: 'accepted_ts_and_cs')
  bool? get acceptedTsAndCs;
  @JsonKey(includeToJson: false)
  @UserRoleConverter()
  UserRole get role;
  @JsonKey(name: 'corp_name')
  String? get corpName;
  @JsonKey(name: 'npc_reg')
  String? get npcReg;
  @JsonKey(name: 'corp_reg')
  String? get corpReg;
  @JsonKey(name: 'corp_address_id')
  int? get corpAddressId;
  @JsonKey(name: 'corp_vat_no')
  String? get corpVatNo;
  @JsonKey(name: 'is_approved', includeToJson: false)
  bool? get isApproved;
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime? get createdAt;
  @JsonKey(name: 'referral_code', includeToJson: false)
  int? get referralCode;
  @JsonKey(name: 'is_verified', includeToJson: false)
  bool get isVerified;
  @JsonKey(name: 'foreigner', includeToJson: true)
  bool? get foreigner;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProfileCopyWith<Profile> get copyWith =>
      _$ProfileCopyWithImpl<Profile>(this as Profile, _$identity);

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Profile &&
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

  @override
  String toString() {
    return 'Profile(userId: $userId, rsaIdNumber: $rsaIdNumber, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, isActive: $isActive, deactivatedOn: $deactivatedOn, acceptedTsAndCs: $acceptedTsAndCs, role: $role, corpName: $corpName, npcReg: $npcReg, corpReg: $corpReg, corpAddressId: $corpAddressId, corpVatNo: $corpVatNo, isApproved: $isApproved, createdAt: $createdAt, referralCode: $referralCode, isVerified: $isVerified, foreigner: $foreigner)';
  }
}

/// @nodoc
abstract mixin class $ProfileCopyWith<$Res> {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) _then) =
      _$ProfileCopyWithImpl;
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
class _$ProfileCopyWithImpl<$Res> implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._self, this._then);

  final Profile _self;
  final $Res Function(Profile) _then;

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
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      rsaIdNumber: freezed == rsaIdNumber
          ? _self.rsaIdNumber
          : rsaIdNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      deactivatedOn: freezed == deactivatedOn
          ? _self.deactivatedOn
          : deactivatedOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      acceptedTsAndCs: freezed == acceptedTsAndCs
          ? _self.acceptedTsAndCs
          : acceptedTsAndCs // ignore: cast_nullable_to_non_nullable
              as bool?,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      corpName: freezed == corpName
          ? _self.corpName
          : corpName // ignore: cast_nullable_to_non_nullable
              as String?,
      npcReg: freezed == npcReg
          ? _self.npcReg
          : npcReg // ignore: cast_nullable_to_non_nullable
              as String?,
      corpReg: freezed == corpReg
          ? _self.corpReg
          : corpReg // ignore: cast_nullable_to_non_nullable
              as String?,
      corpAddressId: freezed == corpAddressId
          ? _self.corpAddressId
          : corpAddressId // ignore: cast_nullable_to_non_nullable
              as int?,
      corpVatNo: freezed == corpVatNo
          ? _self.corpVatNo
          : corpVatNo // ignore: cast_nullable_to_non_nullable
              as String?,
      isApproved: freezed == isApproved
          ? _self.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      referralCode: freezed == referralCode
          ? _self.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as int?,
      isVerified: null == isVerified
          ? _self.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      foreigner: freezed == foreigner
          ? _self.foreigner
          : foreigner // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Profile implements Profile {
  const _Profile(
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
  factory _Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

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

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProfileCopyWith<_Profile> get copyWith =>
      __$ProfileCopyWithImpl<_Profile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProfileToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Profile &&
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

  @override
  String toString() {
    return 'Profile(userId: $userId, rsaIdNumber: $rsaIdNumber, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, isActive: $isActive, deactivatedOn: $deactivatedOn, acceptedTsAndCs: $acceptedTsAndCs, role: $role, corpName: $corpName, npcReg: $npcReg, corpReg: $corpReg, corpAddressId: $corpAddressId, corpVatNo: $corpVatNo, isApproved: $isApproved, createdAt: $createdAt, referralCode: $referralCode, isVerified: $isVerified, foreigner: $foreigner)';
  }
}

/// @nodoc
abstract mixin class _$ProfileCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$ProfileCopyWith(_Profile value, $Res Function(_Profile) _then) =
      __$ProfileCopyWithImpl;
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
class __$ProfileCopyWithImpl<$Res> implements _$ProfileCopyWith<$Res> {
  __$ProfileCopyWithImpl(this._self, this._then);

  final _Profile _self;
  final $Res Function(_Profile) _then;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_Profile(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      rsaIdNumber: freezed == rsaIdNumber
          ? _self.rsaIdNumber
          : rsaIdNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      deactivatedOn: freezed == deactivatedOn
          ? _self.deactivatedOn
          : deactivatedOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      acceptedTsAndCs: freezed == acceptedTsAndCs
          ? _self.acceptedTsAndCs
          : acceptedTsAndCs // ignore: cast_nullable_to_non_nullable
              as bool?,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      corpName: freezed == corpName
          ? _self.corpName
          : corpName // ignore: cast_nullable_to_non_nullable
              as String?,
      npcReg: freezed == npcReg
          ? _self.npcReg
          : npcReg // ignore: cast_nullable_to_non_nullable
              as String?,
      corpReg: freezed == corpReg
          ? _self.corpReg
          : corpReg // ignore: cast_nullable_to_non_nullable
              as String?,
      corpAddressId: freezed == corpAddressId
          ? _self.corpAddressId
          : corpAddressId // ignore: cast_nullable_to_non_nullable
              as int?,
      corpVatNo: freezed == corpVatNo
          ? _self.corpVatNo
          : corpVatNo // ignore: cast_nullable_to_non_nullable
              as String?,
      isApproved: freezed == isApproved
          ? _self.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      referralCode: freezed == referralCode
          ? _self.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as int?,
      isVerified: null == isVerified
          ? _self.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      foreigner: freezed == foreigner
          ? _self.foreigner
          : foreigner // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

// dart format on
