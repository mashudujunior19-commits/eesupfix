import 'package:freezed_annotation/freezed_annotation.dart';

class OrganisationContactMethodConverter
    implements JsonConverter<OrganisationContactMethod, String> {
  const OrganisationContactMethodConverter();

  @override
  OrganisationContactMethod fromJson(String json) {
    return OrganisationContactMethod.fromString(json);
  }

  @override
  String toJson(OrganisationContactMethod object) {
    return object.toString();
  }
}

enum OrganisationContactMethod {
  email,
  phoneNumber,
  cellNumber;

  @override
  String toString() {
    switch (this) {
      case OrganisationContactMethod.email:
        return 'Email';
      case OrganisationContactMethod.phoneNumber:
        return 'Phone Number';
      case OrganisationContactMethod.cellNumber:
        return 'Cell Number';
    }
  }

  factory OrganisationContactMethod.fromString(String value) {
    switch (value) {
      case 'Email':
        return OrganisationContactMethod.email;
      case 'Phone Number':
        return OrganisationContactMethod.phoneNumber;
      case 'Cell Number':
        return OrganisationContactMethod.cellNumber;
      default:
        throw Exception('Unknown organisation contact method: $value');
    }
  }
}
