part of 'application_surveys_bloc.dart';

@immutable
sealed class ApplicationSurveysEvent {}

final class ApplicationSurveysFetched extends ApplicationSurveysEvent {
  final Partner partner;
  ApplicationSurveysFetched(this.partner);
}

final class ApplicationUpdated extends ApplicationSurveysEvent {
  final PartnerApplication application;
  ApplicationUpdated(this.application);
}
