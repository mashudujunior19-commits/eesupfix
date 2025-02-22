part of 'version_control_bloc.dart';

@immutable
sealed class VersionControlEvent {}

// class CheckAppVersion extends VersionControlEvent {
//   final int currentBuildNumber;

//   CheckAppVersion(this.currentBuildNumber);
// }

class CheckAppVersion extends VersionControlEvent {
  final String currentVersion; // The current version number (e.g., "16.6.21")
  final int currentBuildNumber; // The current build number (e.g., 222)

  CheckAppVersion({
    required this.currentVersion,
    required this.currentBuildNumber,
  });
}
