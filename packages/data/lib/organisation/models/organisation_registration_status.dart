import 'package:freezed_annotation/freezed_annotation.dart';

class OrganisationRegistrationStatusConverter
    implements JsonConverter<OrganisationRegistrationStatus, String> {
  const OrganisationRegistrationStatusConverter();

  @override
  OrganisationRegistrationStatus fromJson(String json) {
    return OrganisationRegistrationStatus.fromString(json);
  }

  @override
  String toJson(OrganisationRegistrationStatus object) {
    return object.toString();
  }
}

enum OrganisationRegistrationStatus {
  registered,
  unregistered;

  @override
  String toString() {
    switch (this) {
      case OrganisationRegistrationStatus.registered:
        return 'Registered';
      case OrganisationRegistrationStatus.unregistered:
        return 'Unregistered';
    }
  }

  factory OrganisationRegistrationStatus.fromString(String value) {
    switch (value) {
      case 'Registered':
        return OrganisationRegistrationStatus.registered;
      case 'Unregistered':
        return OrganisationRegistrationStatus.unregistered;
      default:
        throw Exception('Unknown organisation registration status: $value');
    }
  }
}
