// ignore_for_file: invalid_annotation_target

import 'package:data/geolocation/models/address.dart';
import 'package:data/organisation/models/organisation_contact_method.dart';
import 'package:data/organisation/models/organisation_registration_status.dart';
import 'package:data/organisation/models/organisation_review_status.dart';
import 'package:data/organisation/models/organisation_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'organisation.freezed.dart';
part 'organisation.g.dart';

@freezed
abstract class Organisation with _$Organisation {
  const factory Organisation({
    @JsonKey(includeToJson: false) String? id,
    @JsonKey(name: 'owner_id', includeToJson: false) String? ownerId,
    @JsonKey(name: 'created_at', includeToJson: false) DateTime? createdAt,
    @JsonKey(name: 'reviewed_at', includeToJson: false) DateTime? reviewedAt,
    @OrganisationTypeConverter()
    @JsonKey(name: 'organisation_type')
    required OrganisationType organisationType,
    @OrganisationRegistrationStatusConverter()
    @JsonKey(name: 'registration_status')
    required OrganisationRegistrationStatus registrationStatus,
    @OrganisationReviewStatusConverter()
    @JsonKey(name: 'review_status', includeToJson: false)
    OrganisationReviewStatus? reviewStatus,
    required String name,
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
    @JsonKey(name: 'industry_type') required String industryType,
    @JsonKey(name: 'pbo_number') String? pboNumber,
    @JsonKey(name: 'social_development_number') String? socialDevelopmentNumber,
  }) = _Organisation;

  factory Organisation.fromJson(Map<String, dynamic> json) =>
      _$OrganisationFromJson(json);
}
