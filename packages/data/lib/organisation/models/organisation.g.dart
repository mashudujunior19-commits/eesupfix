// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organisation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Organisation _$OrganisationFromJson(Map<String, dynamic> json) =>
    _Organisation(
      id: json['id'] as String?,
      ownerId: json['owner_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      reviewedAt: json['reviewed_at'] == null
          ? null
          : DateTime.parse(json['reviewed_at'] as String),
      organisationType: const OrganisationTypeConverter()
          .fromJson(json['organisation_type'] as String),
      registrationStatus: const OrganisationRegistrationStatusConverter()
          .fromJson(json['registration_status'] as String),
      reviewStatus: _$JsonConverterFromJson<String, OrganisationReviewStatus>(
          json['review_status'],
          const OrganisationReviewStatusConverter().fromJson),
      name: json['name'] as String,
      surname: json['surname'] as String?,
      addressId: (json['address_id'] as num?)?.toInt(),
      address: _$JsonConverterFromJson<Map<String, dynamic>, Address>(
          json['address'], const AddressConverter().fromJson),
      contactPerson1: json['contact_person_1'] as String?,
      contactPerson2: json['contact_person_2'] as String?,
      contactPerson3: json['contact_person_3'] as String?,
      contactMethod: _$JsonConverterFromJson<String, OrganisationContactMethod>(
          json['contact_method'],
          const OrganisationContactMethodConverter().fromJson),
      contactValue: json['contact_value'] as String?,
      companyRegistrationNumber: json['company_registration_number'] as String?,
      vatNumber: json['vat_number'] as String?,
      industryType: json['industry_type'] as String,
      pboNumber: json['pbo_number'] as String?,
      socialDevelopmentNumber: json['social_development_number'] as String?,
    );

Map<String, dynamic> _$OrganisationToJson(_Organisation instance) =>
    <String, dynamic>{
      'organisation_type':
          const OrganisationTypeConverter().toJson(instance.organisationType),
      'registration_status': const OrganisationRegistrationStatusConverter()
          .toJson(instance.registrationStatus),
      'name': instance.name,
      'surname': instance.surname,
      'address_id': instance.addressId,
      'contact_person_1': instance.contactPerson1,
      'contact_person_2': instance.contactPerson2,
      'contact_person_3': instance.contactPerson3,
      'contact_method':
          _$JsonConverterToJson<String, OrganisationContactMethod>(
              instance.contactMethod,
              const OrganisationContactMethodConverter().toJson),
      'contact_value': instance.contactValue,
      'company_registration_number': instance.companyRegistrationNumber,
      'vat_number': instance.vatNumber,
      'industry_type': instance.industryType,
      'pbo_number': instance.pboNumber,
      'social_development_number': instance.socialDevelopmentNumber,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
