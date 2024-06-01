part of 'survey_response_bloc.dart';

@immutable
sealed class SurveyResponseState {}

final class SurveyResponseInitial extends SurveyResponseState {}

final class CurrentResponseSurvey extends SurveyResponseState {
  final Survey survey;
  final int index;
  CurrentResponseSurvey(this.survey, this.index);
  Question get currentQuestion => survey.questions[index];
}
