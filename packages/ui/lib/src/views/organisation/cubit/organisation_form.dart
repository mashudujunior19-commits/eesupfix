import 'package:data/geolocation/models/address.dart';
import 'package:data/organisation/models/organisation.dart';
import 'package:data/organisation/models/organisation_contact_method.dart';
import 'package:data/organisation/models/organisation_registration_status.dart';
import 'package:data/organisation/models/organisation_type.dart';
import 'package:data/utils/validate_organisation_fields.dart'
    as org_validators;
import 'package:dart_mappable/dart_mappable.dart';
import 'package:email_validator/email_validator.dart';

part 'organisation_form.mapper.dart';

@MappableClass(generateMethods: GenerateMethods.equals | GenerateMethods.copy)
class OrganisationForm with OrganisationFormMappable {
  final OrganisationType? orgType;
  final OrganisationRegistrationStatus? registrationStatus;
  final String? name;
  final String? surname;
  final int? addressId;
  final Address? address;
  final String? contactPerson1;
  final String? contactPerson2;
  final String? contactPerson3;
  final OrganisationContactMethod? contactMethod;
  final String? contactValue;
  final String? companyRegistrationNumber;
  final String? vatNumber;
  final String? industryType;
  final String? pboNumber;
  final String? socialDevelopmentNumber;
  final bool isLoading;
  final OrganisationSubmitStatus status;
  final String? errorMessage;

  OrganisationForm({
    this.orgType,
    this.registrationStatus,
    this.name,
    this.surname,
    this.addressId,
    this.address,
    this.contactPerson1,
    this.contactPerson2,
    this.contactPerson3,
    this.contactMethod,
    this.contactValue,
    this.companyRegistrationNumber,
    this.vatNumber,
    this.industryType,
    this.pboNumber,
    this.socialDevelopmentNumber,
    this.errorMessage,
    required this.isLoading,
    required this.status,
  });

  factory OrganisationForm.initial() => OrganisationForm(
        isLoading: false,
        status: OrganisationSubmitStatus.init,
      );

  bool get isNPO => orgType == OrganisationType.publicBenefit;
  bool get isRegistered =>
      registrationStatus == OrganisationRegistrationStatus.registered;
  bool get isUnregistered =>
      registrationStatus == OrganisationRegistrationStatus.unregistered;

  bool isValidCompanyRegistrationNumber() {
    if (companyRegistrationNumber == null) return false;
    return org_validators
        .isValidCompanyRegistrationNumber(companyRegistrationNumber!);
  }

  bool isValidVATNumber() {
    if (vatNumber == null || vatNumber!.isEmpty) return true; // optional
    return org_validators.isValidVATNumber(vatNumber!);
  }

  bool isValidPBONumber() {
    if (pboNumber == null) return false;
    return org_validators.isValidPBONumber(pboNumber!);
  }

  bool isValidContactValue() {
    if (contactValue == null || contactMethod == null) return false;
    switch (contactMethod!) {
      case OrganisationContactMethod.email:
        return EmailValidator.validate(contactValue!);
      case OrganisationContactMethod.phoneNumber:
      case OrganisationContactMethod.cellNumber:
        return org_validators.isValidSouthAfricanPhoneOrCell(contactValue!);
    }
  }

  Organisation toOrganisation() {
    return Organisation(
      organisationType: orgType!,
      registrationStatus: registrationStatus!,
      name: name!,
      surname: isRegistered ? surname : null,
      addressId: addressId,
      contactPerson1: contactPerson1,
      contactPerson2: isRegistered ? contactPerson2 : null,
      contactPerson3: isRegistered ? contactPerson3 : null,
      contactMethod: isUnregistered ? contactMethod : null,
      contactValue: isUnregistered ? contactValue : null,
      companyRegistrationNumber:
          isRegistered ? companyRegistrationNumber : null,
      vatNumber: isRegistered && vatNumber != null && vatNumber!.isNotEmpty
          ? vatNumber
          : null,
      industryType: industryType!,
      pboNumber: isRegistered && isNPO ? pboNumber : null,
      socialDevelopmentNumber:
          isRegistered && isNPO ? socialDevelopmentNumber : null,
    );
  }
}

enum OrganisationSubmitStatus {
  init,
  success,
  failed,
}
