part of 'applications_bloc.dart';

@immutable
sealed class ApplicationsState {}

final class ApplicationsLoading extends ApplicationsState {}

final class ApplicationsError extends ApplicationsState {
  final EESUpException exception;
  ApplicationsError(this.exception);
}

final class ApplicationsLoaded extends ApplicationsState {
  final List<PartnerApplication> applications;
  ApplicationsLoaded(this.applications);
}
