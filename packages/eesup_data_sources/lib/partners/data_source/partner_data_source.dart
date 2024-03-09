import 'package:eesup_data_source/partners/models/partner.dart';
import 'package:eesup_data_source/partners/models/partner_application.dart';
import 'package:eesup_data_source/surveys/models/survey.dart';


abstract class PartnerDataSource {
  Future<List<Partner>> fetchPartnerships();
  Future<List<Survey>> fetchPartnerShipSurveys(String userId, List<String> surveys);
  Future<List<PartnerApplication>> fetchPartnerApplications(String userId,String partnerId);
   Future<int> createPartnerApplications(String userId,String partnerId);

   Future<bool> updatePartnerApplications(PartnerApplication application);
}
