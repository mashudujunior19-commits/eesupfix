part of 'partners_bloc.dart';

@immutable
sealed class PartnersState {}

final class PartnersLoading extends PartnersState {}

final class PartnersError extends PartnersState {
  final EESUpException error;
  PartnersError(this.error);
}

final class PartnersLoaded extends PartnersState {
  final List<Partner> applications;
  PartnersLoaded(this.applications);
}
