import 'package:freezed_annotation/freezed_annotation.dart';

class OrganisationTypeConverter
    implements JsonConverter<OrganisationType, String> {
  const OrganisationTypeConverter();

  @override
  OrganisationType fromJson(String json) {
    return OrganisationType.fromString(json);
  }

  @override
  String toJson(OrganisationType object) {
    return object.toString();
  }
}

enum OrganisationType {
  publicBenefit,
  business;

  @override
  String toString() {
    switch (this) {
      case OrganisationType.publicBenefit:
        return 'Public Benefit';
      case OrganisationType.business:
        return 'Business';
    }
  }

  /// User-facing label, matching the wording used in the registration wizard.
  String get displayName {
    switch (this) {
      case OrganisationType.publicBenefit:
        return 'Public Benefit (NPO)';
      case OrganisationType.business:
        return 'Business (For-Profit)';
    }
  }

  factory OrganisationType.fromString(String value) {
    switch (value) {
      case 'Public Benefit':
        return OrganisationType.publicBenefit;
      case 'Business':
        return OrganisationType.business;
      default:
        throw Exception('Unknown organisation type: $value');
    }
  }
}
