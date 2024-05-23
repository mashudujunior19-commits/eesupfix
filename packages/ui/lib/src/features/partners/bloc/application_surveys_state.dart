part of 'application_surveys_bloc.dart';

@immutable
sealed class ApplicationSurveysState {}

final class ApplicationSurveysLoading extends ApplicationSurveysState {}

final class ApplicationSurveysUpdatedSuccess extends ApplicationSurveysState {}

final class ApplicationSurveysUpdatedFailed extends ApplicationSurveysState {}

final class ApplicationSurveysError extends ApplicationSurveysState {
  final EESUpException err;
  ApplicationSurveysError(this.err);
}

typedef IndexedSurvey = ({int index, Survey survey});

final class ApplicationSurveysLoaded extends ApplicationSurveysState {
  final List<IndexedSurvey> surveys;
  ApplicationSurveysLoaded(this.surveys);
}


