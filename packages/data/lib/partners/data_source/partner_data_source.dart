import 'package:data/auth/models/user_role.dart';
import 'package:data/partners/models/partner.dart';
import 'package:data/partners/models/partner_application.dart';
import 'package:data/surveys/models/survey.dart';

abstract class PartnerDataSource {
  Future<List<Partner>> fetchPartnerships(UserRole role);
  Future<List<Survey>> fetchPartnerShipSurveys(
      String userId, List<String> surveys);
  Future<List<PartnerApplication>> fetchPartnerApplications(
      String userId, String partnerId);
  Future<int> createPartnerApplications(String userId, String partnerId);

  /// Whether the signed-in user may apply for this partnership, and if not,
  /// why (e.g. KasiPreneur needs a public KasiPool of 25+ members; Kasi Spaza
  /// needs an existing KasiPreneur).
  Future<({bool eligible, String? reason})> fetchEligibility(String partnerId);

  Future<bool> updatePartnerApplications(PartnerApplication application);
}
