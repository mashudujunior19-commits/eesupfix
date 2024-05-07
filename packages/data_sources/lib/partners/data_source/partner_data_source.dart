import 'package:data_sources/auth/models/user_role.dart';
import 'package:data_sources/partners/models/partner.dart';
import 'package:data_sources/partners/models/partner_application.dart';
import 'package:data_sources/surveys/models/survey.dart';

abstract class PartnerDataSource {
  Future<List<Partner>> fetchPartnerships(UserRole role);
  Future<List<Survey>> fetchPartnerShipSurveys(
      String userId, List<String> surveys);
  Future<List<PartnerApplication>> fetchPartnerApplications(
      String userId, String partnerId);
  Future<int> createPartnerApplications(String userId, String partnerId);

  Future<bool> updatePartnerApplications(PartnerApplication application);
}
