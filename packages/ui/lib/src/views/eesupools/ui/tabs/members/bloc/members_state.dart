part of 'members_bloc.dart';

@immutable
sealed class MembersState {}

final class MembersLoading extends MembersState {}

final class MembersLoadingError extends MembersState {
  final EESUpException error;
  MembersLoadingError(this.error);
}

final class MembersLoaded extends MembersState {
  final List<EESUpoolMember> members;
  MembersLoaded(this.members);
}
