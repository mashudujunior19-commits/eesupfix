import 'dart:io';
import 'package:data_sources/surveys/data_source/survey_data_source.dart';
import 'package:data_sources/surveys/models/survey.dart';
import 'package:data_sources/surveys/models/survey_response.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SurveySupaseImpl implements SurveyDataSource {
  final SupabaseClient _client;

  SurveySupaseImpl(this._client);

  @override
  Future<List<Survey>> fetchSurveys(String userId, SurveyType type) async {
    final surveys = await _client.schema('engagements').rpc(
        'get_user_avail_surveys',
        params: {'_user_id': userId, '_type': type.name});
    return (surveys as List).map((e) => Survey.fromJson(e)).toList();
  }

  @override
  Future<String?> uploadFile(String name, File file) async {
    try {
      await _client.storage.from('survey_files').upload(name, file);
      String url = _client.storage.from('survey_files').getPublicUrl(name);
      return url;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> saveResponse(SurveyResponse response) async {
    try {
      final alreadySubmitted = await this.alreadySubmitted(
        response.userId,
        response.surveyId,
      );

      if (!alreadySubmitted) {
        final res = await _client
            .schema('engagements')
            .from('response')
            .insert(response.toJson())
            .select('id')
            .single();
        return res['id'];
      } else {
        final res = await _client
            .schema('engagements')
            .from('response')
            .update(response.toJson())
            .eq('user_id', response.userId)
            .eq('survey_id', response.surveyId)
            .select('id')
            .single();
        return res['id'];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  @override
  Future<bool> alreadySubmitted(String userId, String surveyId) async {
    int res = await _client
        .schema('engagements')
        .from('response')
        .count()
        .eq('user_id', userId)
        .eq('survey_id', surveyId);
    return res > 0;
  }
}
