part of 'version_control_bloc.dart';

@immutable
sealed class VersionControlState {}

final class VersionControlInitial extends VersionControlState {}

class VersionUpToDate extends VersionControlState {}

class VersionOutdated extends VersionControlState {}

class VersionControlError extends VersionControlState {
  final EESUpException error;
  VersionControlError(this.error);
}
