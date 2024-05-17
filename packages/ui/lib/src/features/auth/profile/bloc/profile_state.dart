part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileError extends ProfileState {
  final EESUpException ex;
  ProfileError(this.ex);
}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final Profile profile;
  ProfileLoaded(this.profile);
}
