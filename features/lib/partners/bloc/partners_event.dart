part of 'partners_bloc.dart';

@immutable
sealed class PartnersEvent {}

final class PartnersFetched extends PartnersEvent {
  final UserRole role;
  PartnersFetched(this.role);
}
