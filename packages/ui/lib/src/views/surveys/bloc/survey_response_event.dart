part of 'survey_response_bloc.dart';

@immutable
sealed class SurveyResponseEvent {}

final class ResponseInitialized extends SurveyResponseEvent {
  final Survey survey;
  ResponseInitialized(this.survey);
}

final class NextQuestionPressed extends SurveyResponseEvent {
  final int next;
  NextQuestionPressed(this.next);
}

final class PrevQuestionPressed extends SurveyResponseEvent {
  final int next;
  PrevQuestionPressed(this.next);
}

final class QuestionResponseUpdated extends SurveyResponseEvent {
  final Question question;
  QuestionResponseUpdated(this.question);
}

final class MultiChoiceResponseUpdated extends SurveyResponseEvent {
  final Choice choice;
  MultiChoiceResponseUpdated(this.choice);
}

final class ResponseSubmited extends SurveyResponseEvent {
  final Survey survey;
  ResponseSubmited(this.survey);
}
