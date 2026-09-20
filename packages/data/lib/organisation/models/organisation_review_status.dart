import 'package:freezed_annotation/freezed_annotation.dart';

class OrganisationReviewStatusConverter
    implements JsonConverter<OrganisationReviewStatus, String> {
  const OrganisationReviewStatusConverter();

  @override
  OrganisationReviewStatus fromJson(String json) {
    return OrganisationReviewStatus.fromString(json);
  }

  @override
  String toJson(OrganisationReviewStatus object) {
    return object.toString();
  }
}

enum OrganisationReviewStatus {
  pending,
  approved,
  rejected;

  @override
  String toString() {
    switch (this) {
      case OrganisationReviewStatus.pending:
        return 'Pending';
      case OrganisationReviewStatus.approved:
        return 'Approved';
      case OrganisationReviewStatus.rejected:
        return 'Rejected';
    }
  }

  factory OrganisationReviewStatus.fromString(String value) {
    switch (value) {
      case 'Pending':
        return OrganisationReviewStatus.pending;
      case 'Approved':
        return OrganisationReviewStatus.approved;
      case 'Rejected':
        return OrganisationReviewStatus.rejected;
      default:
        throw Exception('Unknown organisation review status: $value');
    }
  }
}
