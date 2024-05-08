part of 'surveys_list_bloc.dart';

@immutable
sealed class SurveysListState {}

final class SurveysListLoading extends SurveysListState {}

final class SurveysListError extends SurveysListState {
  final EESUpException exception;
  SurveysListError(this.exception);
}

final class SurveysListLoaded extends SurveysListState {
  final List<Survey> surveys;
  final List<Survey> tests;
  SurveysListLoaded(this.surveys, this.tests);
}
