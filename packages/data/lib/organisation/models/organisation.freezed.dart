// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organisation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Organisation {
  @JsonKey(includeToJson: false)
  String? get id;
  @JsonKey(name: 'owner_id', includeToJson: false)
  String? get ownerId;
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime? get createdAt;
  @JsonKey(name: 'reviewed_at', includeToJson: false)
  DateTime? get reviewedAt;
  @OrganisationTypeConverter()
  @JsonKey(name: 'organisation_type')
  OrganisationType get organisationType;
  @OrganisationRegistrationStatusConverter()
  @JsonKey(name: 'registration_status')
  OrganisationRegistrationStatus get registrationStatus;
  @OrganisationReviewStatusConverter()
  @JsonKey(name: 'review_status', includeToJson: false)
  OrganisationReviewStatus? get reviewStatus;
  String get name;
  String? get surname;
  @JsonKey(name: 'address_id')
  int? get addressId;
  @AddressConverter()
  @JsonKey(includeToJson: false)
  Address? get address;
  @JsonKey(name: 'contact_person_1')
  String? get contactPerson1;
  @JsonKey(name: 'contact_person_2')
  String? get contactPerson2;
  @JsonKey(name: 'contact_person_3')
  String? get contactPerson3;
  @OrganisationContactMethodConverter()
  @JsonKey(name: 'contact_method')
  OrganisationContactMethod? get contactMethod;
  @JsonKey(name: 'contact_value')
  String? get contactValue;
  @JsonKey(name: 'company_registration_number')
  String? get companyRegistrationNumber;
  @JsonKey(name: 'vat_number')
  String? get vatNumber;
  @JsonKey(name: 'industry_type')
  String get industryType;
  @JsonKey(name: 'pbo_number')
  String? get pboNumber;
  @JsonKey(name: 'social_development_number')
  String? get socialDevelopmentNumber;

  /// Create a copy of Organisation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrganisationCopyWith<Organisation> get copyWith =>
      _$OrganisationCopyWithImpl<Organisation>(
          this as Organisation, _$identity);

  /// Serializes this Organisation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Organisation &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.reviewedAt, reviewedAt) ||
                other.reviewedAt == reviewedAt) &&
            (identical(other.organisationType, organisationType) ||
                other.organisationType == organisationType) &&
            (identical(other.registrationStatus, registrationStatus) ||
                other.registrationStatus == registrationStatus) &&
            (identical(other.reviewStatus, reviewStatus) ||
                other.reviewStatus == reviewStatus) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.addressId, addressId) ||
                other.addressId == addressId) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.contactPerson1, contactPerson1) ||
                other.contactPerson1 == contactPerson1) &&
            (identical(other.contactPerson2, contactPerson2) ||
                other.contactPerson2 == contactPerson2) &&
            (identical(other.contactPerson3, contactPerson3) ||
                other.contactPerson3 == contactPerson3) &&
            (identical(other.contactMethod, contactMethod) ||
                other.contactMethod == contactMethod) &&
            (identical(other.contactValue, contactValue) ||
                other.contactValue == contactValue) &&
            (identical(other.companyRegistrationNumber,
                    companyRegistrationNumber) ||
                other.companyRegistrationNumber == companyRegistrationNumber) &&
            (identical(other.vatNumber, vatNumber) ||
                other.vatNumber == vatNumber) &&
            (identical(other.industryType, industryType) ||
                other.industryType == industryType) &&
            (identical(other.pboNumber, pboNumber) ||
                other.pboNumber == pboNumber) &&
            (identical(
                    other.socialDevelopmentNumber, socialDevelopmentNumber) ||
                other.socialDevelopmentNumber == socialDevelopmentNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        ownerId,
        createdAt,
        reviewedAt,
        organisationType,
        registrationStatus,
        reviewStatus,
        name,
        surname,
        addressId,
        address,
        contactPerson1,
        contactPerson2,
        contactPerson3,
        contactMethod,
        contactValue,
        companyRegistrationNumber,
        vatNumber,
        industryType,
        pboNumber,
        socialDevelopmentNumber
      ]);

  @override
  String toString() {
    return 'Organisation(id: $id, ownerId: $ownerId, createdAt: $createdAt, reviewedAt: $reviewedAt, organisationType: $organisationType, registrationStatus: $registrationStatus, reviewStatus: $reviewStatus, name: $name, surname: $surname, addressId: $addressId, address: $address, contactPerson1: $contactPerson1, contactPerson2: $contactPerson2, contactPerson3: $contactPerson3, contactMethod: $contactMethod, contactValue: $contactValue, companyRegistrationNumber: $companyRegistrationNumber, vatNumber: $vatNumber, industryType: $industryType, pboNumber: $pboNumber, socialDevelopmentNumber: $socialDevelopmentNumber)';
  }
}

/// @nodoc
abstract mixin class $OrganisationCopyWith<$Res> {
  factory $OrganisationCopyWith(
          Organisation value, $Res Function(Organisation) _then) =
      _$OrganisationCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String? id,
      @JsonKey(name: 'owner_id', includeToJson: false) String? ownerId,
      @JsonKey(name: 'created_at', includeToJson: false) DateTime? createdAt,
      @JsonKey(name: 'reviewed_at', includeToJson: false) DateTime? reviewedAt,
      @OrganisationTypeConverter()
      @JsonKey(name: 'organisation_type')
      OrganisationType organisationType,
      @OrganisationRegistrationStatusConverter()
      @JsonKey(name: 'registration_status')
      OrganisationRegistrationStatus registrationStatus,
      @OrganisationReviewStatusConverter()
      @JsonKey(name: 'review_status', includeToJson: false)
      OrganisationReviewStatus? reviewStatus,
      String name,
      String? surname,
      @JsonKey(name: 'address_id') int? addressId,
      @AddressConverter() @JsonKey(includeToJson: false) Address? address,
      @JsonKey(name: 'contact_person_1') String? contactPerson1,
      @JsonKey(name: 'contact_person_2') String? contactPerson2,
      @JsonKey(name: 'contact_person_3') String? contactPerson3,
      @OrganisationContactMethodConverter()
      @JsonKey(name: 'contact_method')
      OrganisationContactMethod? contactMethod,
      @JsonKey(name: 'contact_value') String? contactValue,
      @JsonKey(name: 'company_registration_number')
      String? companyRegistrationNumber,
      @JsonKey(name: 'vat_number') String? vatNumber,
      @JsonKey(name: 'industry_type') String industryType,
      @JsonKey(name: 'pbo_number') String? pboNumber,
      @JsonKey(name: 'social_development_number')
      String? socialDevelopmentNumber});

  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class _$OrganisationCopyWithImpl<$Res> implements $OrganisationCopyWith<$Res> {
  _$OrganisationCopyWithImpl(this._self, this._then);

  final Organisation _self;
  final $Res Function(Organisation) _then;

  /// Create a copy of Organisation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? ownerId = freezed,
    Object? createdAt = freezed,
    Object? reviewedAt = freezed,
    Object? organisationType = null,
    Object? registrationStatus = null,
    Object? reviewStatus = freezed,
    Object? name = null,
    Object? surname = freezed,
    Object? addressId = freezed,
    Object? address = freezed,
    Object? contactPerson1 = freezed,
    Object? contactPerson2 = freezed,
    Object? contactPerson3 = freezed,
    Object? contactMethod = freezed,
    Object? contactValue = freezed,
    Object? companyRegistrationNumber = freezed,
    Object? vatNumber = freezed,
    Object? industryType = null,
    Object? pboNumber = freezed,
    Object? socialDevelopmentNumber = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: freezed == ownerId
          ? _self.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reviewedAt: freezed == reviewedAt
          ? _self.reviewedAt
          : reviewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      organisationType: null == organisationType
          ? _self.organisationType
          : organisationType // ignore: cast_nullable_to_non_nullable
              as OrganisationType,
      registrationStatus: null == registrationStatus
          ? _self.registrationStatus
          : registrationStatus // ignore: cast_nullable_to_non_nullable
              as OrganisationRegistrationStatus,
      reviewStatus: freezed == reviewStatus
          ? _self.reviewStatus
          : reviewStatus // ignore: cast_nullable_to_non_nullable
              as OrganisationReviewStatus?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: freezed == surname
          ? _self.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String?,
      addressId: freezed == addressId
          ? _self.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as int?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      contactPerson1: freezed == contactPerson1
          ? _self.contactPerson1
          : contactPerson1 // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPerson2: freezed == contactPerson2
          ? _self.contactPerson2
          : contactPerson2 // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPerson3: freezed == contactPerson3
          ? _self.contactPerson3
          : contactPerson3 // ignore: cast_nullable_to_non_nullable
              as String?,
      contactMethod: freezed == contactMethod
          ? _self.contactMethod
          : contactMethod // ignore: cast_nullable_to_non_nullable
              as OrganisationContactMethod?,
      contactValue: freezed == contactValue
          ? _self.contactValue
          : contactValue // ignore: cast_nullable_to_non_nullable
              as String?,
      companyRegistrationNumber: freezed == companyRegistrationNumber
          ? _self.companyRegistrationNumber
          : companyRegistrationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      vatNumber: freezed == vatNumber
          ? _self.vatNumber
          : vatNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      industryType: null == industryType
          ? _self.industryType
          : industryType // ignore: cast_nullable_to_non_nullable
              as String,
      pboNumber: freezed == pboNumber
          ? _self.pboNumber
          : pboNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      socialDevelopmentNumber: freezed == socialDevelopmentNumber
          ? _self.socialDevelopmentNumber
          : socialDevelopmentNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of Organisation
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

/// Adds pattern-matching-related methods to [Organisation].
extension OrganisationPatterns on Organisation {
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
    TResult Function(_Organisation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Organisation() when $default != null:
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
    TResult Function(_Organisation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Organisation():
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
    TResult? Function(_Organisation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Organisation() when $default != null:
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
            @JsonKey(includeToJson: false) String? id,
            @JsonKey(name: 'owner_id', includeToJson: false) String? ownerId,
            @JsonKey(name: 'created_at', includeToJson: false)
            DateTime? createdAt,
            @JsonKey(name: 'reviewed_at', includeToJson: false)
            DateTime? reviewedAt,
            @OrganisationTypeConverter()
            @JsonKey(name: 'organisation_type')
            OrganisationType organisationType,
            @OrganisationRegistrationStatusConverter()
            @JsonKey(name: 'registration_status')
            OrganisationRegistrationStatus registrationStatus,
            @OrganisationReviewStatusConverter()
            @JsonKey(name: 'review_status', includeToJson: false)
            OrganisationReviewStatus? reviewStatus,
            String name,
            String? surname,
            @JsonKey(name: 'address_id') int? addressId,
            @AddressConverter() @JsonKey(includeToJson: false) Address? address,
            @JsonKey(name: 'contact_person_1') String? contactPerson1,
            @JsonKey(name: 'contact_person_2') String? contactPerson2,
            @JsonKey(name: 'contact_person_3') String? contactPerson3,
            @OrganisationContactMethodConverter()
            @JsonKey(name: 'contact_method')
            OrganisationContactMethod? contactMethod,
            @JsonKey(name: 'contact_value') String? contactValue,
            @JsonKey(name: 'company_registration_number')
            String? companyRegistrationNumber,
            @JsonKey(name: 'vat_number') String? vatNumber,
            @JsonKey(name: 'industry_type') String industryType,
            @JsonKey(name: 'pbo_number') String? pboNumber,
            @JsonKey(name: 'social_development_number')
            String? socialDevelopmentNumber)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Organisation() when $default != null:
        return $default(
            _that.id,
            _that.ownerId,
            _that.createdAt,
            _that.reviewedAt,
            _that.organisationType,
            _that.registrationStatus,
            _that.reviewStatus,
            _that.name,
            _that.surname,
            _that.addressId,
            _that.address,
            _that.contactPerson1,
            _that.contactPerson2,
            _that.contactPerson3,
            _that.contactMethod,
            _that.contactValue,
            _that.companyRegistrationNumber,
            _that.vatNumber,
            _that.industryType,
            _that.pboNumber,
            _that.socialDevelopmentNumber);
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
            @JsonKey(includeToJson: false) String? id,
            @JsonKey(name: 'owner_id', includeToJson: false) String? ownerId,
            @JsonKey(name: 'created_at', includeToJson: false)
            DateTime? createdAt,
            @JsonKey(name: 'reviewed_at', includeToJson: false)
            DateTime? reviewedAt,
            @OrganisationTypeConverter()
            @JsonKey(name: 'organisation_type')
            OrganisationType organisationType,
            @OrganisationRegistrationStatusConverter()
            @JsonKey(name: 'registration_status')
            OrganisationRegistrationStatus registrationStatus,
            @OrganisationReviewStatusConverter()
            @JsonKey(name: 'review_status', includeToJson: false)
            OrganisationReviewStatus? reviewStatus,
            String name,
            String? surname,
            @JsonKey(name: 'address_id') int? addressId,
            @AddressConverter() @JsonKey(includeToJson: false) Address? address,
            @JsonKey(name: 'contact_person_1') String? contactPerson1,
            @JsonKey(name: 'contact_person_2') String? contactPerson2,
            @JsonKey(name: 'contact_person_3') String? contactPerson3,
            @OrganisationContactMethodConverter()
            @JsonKey(name: 'contact_method')
            OrganisationContactMethod? contactMethod,
            @JsonKey(name: 'contact_value') String? contactValue,
            @JsonKey(name: 'company_registration_number')
            String? companyRegistrationNumber,
            @JsonKey(name: 'vat_number') String? vatNumber,
            @JsonKey(name: 'industry_type') String industryType,
            @JsonKey(name: 'pbo_number') String? pboNumber,
            @JsonKey(name: 'social_development_number')
            String? socialDevelopmentNumber)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Organisation():
        return $default(
            _that.id,
            _that.ownerId,
            _that.createdAt,
            _that.reviewedAt,
            _that.organisationType,
            _that.registrationStatus,
            _that.reviewStatus,
            _that.name,
            _that.surname,
            _that.addressId,
            _that.address,
            _that.contactPerson1,
            _that.contactPerson2,
            _that.contactPerson3,
            _that.contactMethod,
            _that.contactValue,
            _that.companyRegistrationNumber,
            _that.vatNumber,
            _that.industryType,
            _that.pboNumber,
            _that.socialDevelopmentNumber);
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
            @JsonKey(includeToJson: false) String? id,
            @JsonKey(name: 'owner_id', includeToJson: false) String? ownerId,
            @JsonKey(name: 'created_at', includeToJson: false)
            DateTime? createdAt,
            @JsonKey(name: 'reviewed_at', includeToJson: false)
            DateTime? reviewedAt,
            @OrganisationTypeConverter()
            @JsonKey(name: 'organisation_type')
            OrganisationType organisationType,
            @OrganisationRegistrationStatusConverter()
            @JsonKey(name: 'registration_status')
            OrganisationRegistrationStatus registrationStatus,
            @OrganisationReviewStatusConverter()
            @JsonKey(name: 'review_status', includeToJson: false)
            OrganisationReviewStatus? reviewStatus,
            String name,
            String? surname,
            @JsonKey(name: 'address_id') int? addressId,
            @AddressConverter() @JsonKey(includeToJson: false) Address? address,
            @JsonKey(name: 'contact_person_1') String? contactPerson1,
            @JsonKey(name: 'contact_person_2') String? contactPerson2,
            @JsonKey(name: 'contact_person_3') String? contactPerson3,
            @OrganisationContactMethodConverter()
            @JsonKey(name: 'contact_method')
            OrganisationContactMethod? contactMethod,
            @JsonKey(name: 'contact_value') String? contactValue,
            @JsonKey(name: 'company_registration_number')
            String? companyRegistrationNumber,
            @JsonKey(name: 'vat_number') String? vatNumber,
            @JsonKey(name: 'industry_type') String industryType,
            @JsonKey(name: 'pbo_number') String? pboNumber,
            @JsonKey(name: 'social_development_number')
            String? socialDevelopmentNumber)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Organisation() when $default != null:
        return $default(
            _that.id,
            _that.ownerId,
            _that.createdAt,
            _that.reviewedAt,
            _that.organisationType,
            _that.registrationStatus,
            _that.reviewStatus,
            _that.name,
            _that.surname,
            _that.addressId,
            _that.address,
            _that.contactPerson1,
            _that.contactPerson2,
            _that.contactPerson3,
            _that.contactMethod,
            _that.contactValue,
            _that.companyRegistrationNumber,
            _that.vatNumber,
            _that.industryType,
            _that.pboNumber,
            _that.socialDevelopmentNumber);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Organisation implements Organisation {
  const _Organisation(
      {@JsonKey(includeToJson: false) this.id,
      @JsonKey(name: 'owner_id', includeToJson: false) this.ownerId,
      @JsonKey(name: 'created_at', includeToJson: false) this.createdAt,
      @JsonKey(name: 'reviewed_at', includeToJson: false) this.reviewedAt,
      @OrganisationTypeConverter()
      @JsonKey(name: 'organisation_type')
      required this.organisationType,
      @OrganisationRegistrationStatusConverter()
      @JsonKey(name: 'registration_status')
      required this.registrationStatus,
      @OrganisationReviewStatusConverter()
      @JsonKey(name: 'review_status', includeToJson: false)
      this.reviewStatus,
      required this.name,
      this.surname,
      @JsonKey(name: 'address_id') this.addressId,
      @AddressConverter() @JsonKey(includeToJson: false) this.address,
      @JsonKey(name: 'contact_person_1') this.contactPerson1,
      @JsonKey(name: 'contact_person_2') this.contactPerson2,
      @JsonKey(name: 'contact_person_3') this.contactPerson3,
      @OrganisationContactMethodConverter()
      @JsonKey(name: 'contact_method')
      this.contactMethod,
      @JsonKey(name: 'contact_value') this.contactValue,
      @JsonKey(name: 'company_registration_number')
      this.companyRegistrationNumber,
      @JsonKey(name: 'vat_number') this.vatNumber,
      @JsonKey(name: 'industry_type') required this.industryType,
      @JsonKey(name: 'pbo_number') this.pboNumber,
      @JsonKey(name: 'social_development_number')
      this.socialDevelopmentNumber});
  factory _Organisation.fromJson(Map<String, dynamic> json) =>
      _$OrganisationFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final String? id;
  @override
  @JsonKey(name: 'owner_id', includeToJson: false)
  final String? ownerId;
  @override
  @JsonKey(name: 'created_at', includeToJson: false)
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'reviewed_at', includeToJson: false)
  final DateTime? reviewedAt;
  @override
  @OrganisationTypeConverter()
  @JsonKey(name: 'organisation_type')
  final OrganisationType organisationType;
  @override
  @OrganisationRegistrationStatusConverter()
  @JsonKey(name: 'registration_status')
  final OrganisationRegistrationStatus registrationStatus;
  @override
  @OrganisationReviewStatusConverter()
  @JsonKey(name: 'review_status', includeToJson: false)
  final OrganisationReviewStatus? reviewStatus;
  @override
  final String name;
  @override
  final String? surname;
  @override
  @JsonKey(name: 'address_id')
  final int? addressId;
  @override
  @AddressConverter()
  @JsonKey(includeToJson: false)
  final Address? address;
  @override
  @JsonKey(name: 'contact_person_1')
  final String? contactPerson1;
  @override
  @JsonKey(name: 'contact_person_2')
  final String? contactPerson2;
  @override
  @JsonKey(name: 'contact_person_3')
  final String? contactPerson3;
  @override
  @OrganisationContactMethodConverter()
  @JsonKey(name: 'contact_method')
  final OrganisationContactMethod? contactMethod;
  @override
  @JsonKey(name: 'contact_value')
  final String? contactValue;
  @override
  @JsonKey(name: 'company_registration_number')
  final String? companyRegistrationNumber;
  @override
  @JsonKey(name: 'vat_number')
  final String? vatNumber;
  @override
  @JsonKey(name: 'industry_type')
  final String industryType;
  @override
  @JsonKey(name: 'pbo_number')
  final String? pboNumber;
  @override
  @JsonKey(name: 'social_development_number')
  final String? socialDevelopmentNumber;

  /// Create a copy of Organisation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrganisationCopyWith<_Organisation> get copyWith =>
      __$OrganisationCopyWithImpl<_Organisation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OrganisationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Organisation &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.reviewedAt, reviewedAt) ||
                other.reviewedAt == reviewedAt) &&
            (identical(other.organisationType, organisationType) ||
                other.organisationType == organisationType) &&
            (identical(other.registrationStatus, registrationStatus) ||
                other.registrationStatus == registrationStatus) &&
            (identical(other.reviewStatus, reviewStatus) ||
                other.reviewStatus == reviewStatus) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.addressId, addressId) ||
                other.addressId == addressId) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.contactPerson1, contactPerson1) ||
                other.contactPerson1 == contactPerson1) &&
            (identical(other.contactPerson2, contactPerson2) ||
                other.contactPerson2 == contactPerson2) &&
            (identical(other.contactPerson3, contactPerson3) ||
                other.contactPerson3 == contactPerson3) &&
            (identical(other.contactMethod, contactMethod) ||
                other.contactMethod == contactMethod) &&
            (identical(other.contactValue, contactValue) ||
                other.contactValue == contactValue) &&
            (identical(other.companyRegistrationNumber,
                    companyRegistrationNumber) ||
                other.companyRegistrationNumber == companyRegistrationNumber) &&
            (identical(other.vatNumber, vatNumber) ||
                other.vatNumber == vatNumber) &&
            (identical(other.industryType, industryType) ||
                other.industryType == industryType) &&
            (identical(other.pboNumber, pboNumber) ||
                other.pboNumber == pboNumber) &&
            (identical(
                    other.socialDevelopmentNumber, socialDevelopmentNumber) ||
                other.socialDevelopmentNumber == socialDevelopmentNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        ownerId,
        createdAt,
        reviewedAt,
        organisationType,
        registrationStatus,
        reviewStatus,
        name,
        surname,
        addressId,
        address,
        contactPerson1,
        contactPerson2,
        contactPerson3,
        contactMethod,
        contactValue,
        companyRegistrationNumber,
        vatNumber,
        industryType,
        pboNumber,
        socialDevelopmentNumber
      ]);

  @override
  String toString() {
    return 'Organisation(id: $id, ownerId: $ownerId, createdAt: $createdAt, reviewedAt: $reviewedAt, organisationType: $organisationType, registrationStatus: $registrationStatus, reviewStatus: $reviewStatus, name: $name, surname: $surname, addressId: $addressId, address: $address, contactPerson1: $contactPerson1, contactPerson2: $contactPerson2, contactPerson3: $contactPerson3, contactMethod: $contactMethod, contactValue: $contactValue, companyRegistrationNumber: $companyRegistrationNumber, vatNumber: $vatNumber, industryType: $industryType, pboNumber: $pboNumber, socialDevelopmentNumber: $socialDevelopmentNumber)';
  }
}

/// @nodoc
abstract mixin class _$OrganisationCopyWith<$Res>
    implements $OrganisationCopyWith<$Res> {
  factory _$OrganisationCopyWith(
          _Organisation value, $Res Function(_Organisation) _then) =
      __$OrganisationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String? id,
      @JsonKey(name: 'owner_id', includeToJson: false) String? ownerId,
      @JsonKey(name: 'created_at', includeToJson: false) DateTime? createdAt,
      @JsonKey(name: 'reviewed_at', includeToJson: false) DateTime? reviewedAt,
      @OrganisationTypeConverter()
      @JsonKey(name: 'organisation_type')
      OrganisationType organisationType,
      @OrganisationRegistrationStatusConverter()
      @JsonKey(name: 'registration_status')
      OrganisationRegistrationStatus registrationStatus,
      @OrganisationReviewStatusConverter()
      @JsonKey(name: 'review_status', includeToJson: false)
      OrganisationReviewStatus? reviewStatus,
      String name,
      String? surname,
      @JsonKey(name: 'address_id') int? addressId,
      @AddressConverter() @JsonKey(includeToJson: false) Address? address,
      @JsonKey(name: 'contact_person_1') String? contactPerson1,
      @JsonKey(name: 'contact_person_2') String? contactPerson2,
      @JsonKey(name: 'contact_person_3') String? contactPerson3,
      @OrganisationContactMethodConverter()
      @JsonKey(name: 'contact_method')
      OrganisationContactMethod? contactMethod,
      @JsonKey(name: 'contact_value') String? contactValue,
      @JsonKey(name: 'company_registration_number')
      String? companyRegistrationNumber,
      @JsonKey(name: 'vat_number') String? vatNumber,
      @JsonKey(name: 'industry_type') String industryType,
      @JsonKey(name: 'pbo_number') String? pboNumber,
      @JsonKey(name: 'social_development_number')
      String? socialDevelopmentNumber});

  @override
  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class __$OrganisationCopyWithImpl<$Res>
    implements _$OrganisationCopyWith<$Res> {
  __$OrganisationCopyWithImpl(this._self, this._then);

  final _Organisation _self;
  final $Res Function(_Organisation) _then;

  /// Create a copy of Organisation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? ownerId = freezed,
    Object? createdAt = freezed,
    Object? reviewedAt = freezed,
    Object? organisationType = null,
    Object? registrationStatus = null,
    Object? reviewStatus = freezed,
    Object? name = null,
    Object? surname = freezed,
    Object? addressId = freezed,
    Object? address = freezed,
    Object? contactPerson1 = freezed,
    Object? contactPerson2 = freezed,
    Object? contactPerson3 = freezed,
    Object? contactMethod = freezed,
    Object? contactValue = freezed,
    Object? companyRegistrationNumber = freezed,
    Object? vatNumber = freezed,
    Object? industryType = null,
    Object? pboNumber = freezed,
    Object? socialDevelopmentNumber = freezed,
  }) {
    return _then(_Organisation(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: freezed == ownerId
          ? _self.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reviewedAt: freezed == reviewedAt
          ? _self.reviewedAt
          : reviewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      organisationType: null == organisationType
          ? _self.organisationType
          : organisationType // ignore: cast_nullable_to_non_nullable
              as OrganisationType,
      registrationStatus: null == registrationStatus
          ? _self.registrationStatus
          : registrationStatus // ignore: cast_nullable_to_non_nullable
              as OrganisationRegistrationStatus,
      reviewStatus: freezed == reviewStatus
          ? _self.reviewStatus
          : reviewStatus // ignore: cast_nullable_to_non_nullable
              as OrganisationReviewStatus?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: freezed == surname
          ? _self.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String?,
      addressId: freezed == addressId
          ? _self.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as int?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      contactPerson1: freezed == contactPerson1
          ? _self.contactPerson1
          : contactPerson1 // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPerson2: freezed == contactPerson2
          ? _self.contactPerson2
          : contactPerson2 // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPerson3: freezed == contactPerson3
          ? _self.contactPerson3
          : contactPerson3 // ignore: cast_nullable_to_non_nullable
              as String?,
      contactMethod: freezed == contactMethod
          ? _self.contactMethod
          : contactMethod // ignore: cast_nullable_to_non_nullable
              as OrganisationContactMethod?,
      contactValue: freezed == contactValue
          ? _self.contactValue
          : contactValue // ignore: cast_nullable_to_non_nullable
              as String?,
      companyRegistrationNumber: freezed == companyRegistrationNumber
          ? _self.companyRegistrationNumber
          : companyRegistrationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      vatNumber: freezed == vatNumber
          ? _self.vatNumber
          : vatNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      industryType: null == industryType
          ? _self.industryType
          : industryType // ignore: cast_nullable_to_non_nullable
              as String,
      pboNumber: freezed == pboNumber
          ? _self.pboNumber
          : pboNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      socialDevelopmentNumber: freezed == socialDevelopmentNumber
          ? _self.socialDevelopmentNumber
          : socialDevelopmentNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of Organisation
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
