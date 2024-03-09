import 'package:eesup_data_source/partners/data_source/partner_data_source.dart';
import 'package:eesup_data_source/partners/models/partner.dart';
import 'package:eesup_data_source/partners/models/partner_application.dart';
import 'package:eesup_data_source/surveys/models/survey.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PartnerSupabaseImpl implements PartnerDataSource {
  final SupabaseClient _client;

  PartnerSupabaseImpl(this._client);

  @override
  Future<List<Partner>> fetchPartnerships() async {
    final response = await _client
        .schema('services')
        .from('partner')
        .select()
        .eq('is_open', true);
    return response.map((e) => Partner.fromJson(e)).toList();
  }

  @override
  Future<List<Survey>> fetchPartnerShipSurveys(
    String userId,
    List<String> surveys,
  ) async {
    final response = await _client.schema('services').rpc(
      'get_partnership_surveys',
      params: {
        '_user_id': userId,
        '_surveys': surveys,
      },
    );
    return (response as List).map((e) => Survey.fromJson(e)).toList();
  }

  @override
  Future<List<PartnerApplication>> fetchPartnerApplications(
    String userId,
    String partnerId,
  ) async {
    final response = await _client
        .schema('services')
        .from('partner_application')
        .select()
        .eq('partner_id', partnerId)
        .eq('user_id', userId);
    return response.map((e) => PartnerApplication.fromJson(e)).toList();
  }

  @override
  Future<int> createPartnerApplications(String userId, String partnerId) async {
    try {
      final res = await _client
          .schema('services')
          .rpc('create_new_partner_application', params: {
        '_partner_id': partnerId,
        '_user_id': userId,
      });
      print(res);
      return res;
    } catch (e) {
      print(e);
      return 1;
    }
  }

  @override
  Future<bool> updatePartnerApplications(PartnerApplication application) async {
    try {
      await _client.schema('services').from('partner_application').update({
        'survey_responses': application.surveyResponses,
      }).eq('id', application.id);
      return true;
    } catch (e) {
      return false;
    }
  }
}
