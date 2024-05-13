part of 'members_invites_bloc.dart';

@immutable
sealed class MembersInvitesEvent {}

final class MembersInvitesFetched extends MembersInvitesEvent {
  final int poolId;
  final int limit;
  final String type;

  MembersInvitesFetched(this.poolId, this.limit, this.type);
}
