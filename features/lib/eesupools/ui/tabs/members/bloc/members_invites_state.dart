part of 'members_invites_bloc.dart';

@immutable
sealed class MembersInvitesState {}

final class MembersInvitesLoading extends MembersInvitesState {}

final class MembersInvitesError extends MembersInvitesState {
  final EESUpException error;
  MembersInvitesError(this.error);
}

final class MembersInvitesLoaded extends MembersInvitesState {
  final List<EESUpoolRequest> invites;
  MembersInvitesLoaded(this.invites);
}
