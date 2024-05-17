part of 'members_bloc.dart';

@immutable
sealed class MembersEvent {}

final class MembersFetched extends MembersEvent {
  final int poolId;
  final int limit;
  MembersFetched(this.poolId, this.limit);
}
