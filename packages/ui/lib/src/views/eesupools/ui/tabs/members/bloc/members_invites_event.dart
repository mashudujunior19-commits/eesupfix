part of 'members_invites_bloc.dart';

@immutable
sealed class MembersInvitesEvent {}

final class MembersInvitesFetched extends MembersInvitesEvent {
  final int poolId;
  final int limit;
  final String type;

  MembersInvitesFetched(this.poolId, this.limit, this.type);
}

/// Re-fetches the list in place (no loading state), used for realtime updates.
final class MembersInvitesRefreshed extends MembersInvitesEvent {
  final int poolId;
  final int limit;
  final String type;

  MembersInvitesRefreshed(this.poolId, this.limit, this.type);
}
