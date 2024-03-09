import 'dart:io';
import 'package:eesup_data_source/surveys/models/survey.dart';
import 'package:eesup_data_source/surveys/models/survey_response.dart';


abstract class SurveyDataSource {
  Future<List<Survey>> fetchSurveys(String userId, SurveyType type);

  Future<String?> uploadFile(String name,File file);

  Future<String?> saveResponse(SurveyResponse response);

  Future<bool> alreadySubmitted(String userId, String surveyId);

  
}
