import 'package:data/organisation/models/organisation.dart';

abstract class OrganisationDataSource {
  /// Creates a new organisation, returns the created row (including its id and
  /// default review status).
  Future<Organisation> createOrganisation(Organisation organisation);

  /// Returns the organisations owned by the given user.
  Future<List<Organisation>> fetchOrganisationsByOwner(String ownerId);
}
