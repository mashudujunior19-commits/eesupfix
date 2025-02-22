import 'package:bloc/bloc.dart';
import 'package:data/auth/repository/profile_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:meta/meta.dart';

part 'version_control_event.dart';
part 'version_control_state.dart';

class VersionControlBloc
    extends Bloc<VersionControlEvent, VersionControlState> {
  final ProfileRepository _repository;
  VersionControlBloc(this._repository) : super(VersionControlInitial()) {
    // on<CheckAppVersion>((event, emit) async {
    //   final result = await _repository.checkCurrentAppVersion();

    //   result.fold(
    //     (l) {
    //       emit(VersionControlError(
    //         EESUpException(
    //           message: 'Something went wrong.',
    //         ),
    //       ));
    //     },
    //     (latestBuildNumber) {
    //       if (latestBuildNumber == null ||
    //           event.currentBuildNumber >= latestBuildNumber) {
    //         emit(VersionUpToDate());
    //       } else {
    //         emit(VersionOutdated());
    //       }
    //     },
    //   );
    // });
    on<CheckAppVersion>((event, emit) async {
      final result = await _repository.checkCurrentAppVersion();

      result.fold(
        (l) {
          emit(VersionControlError(
            EESUpException(message: 'Something went wrong.'),
          ));
        },
        (latestVersionInfo) {
          if (latestVersionInfo == null) {
            emit(VersionControlError(
              EESUpException(message: 'No version information available.'),
            ));
          } else {
            final latestVersion = latestVersionInfo['version_number'] as String;
            final latestBuildNumber = latestVersionInfo['build_number'] as int;

            // Compare version numbers first
            if (event.currentVersion == latestVersion) {
              // If version is the same, check build number
              if (event.currentBuildNumber >= latestBuildNumber) {
                emit(VersionUpToDate());
              } else {
                emit(VersionOutdated());
              }
            } else if (event.currentVersion.compareTo(latestVersion) > 0) {
              // Current version is higher than latest version
              emit(VersionUpToDate());
            } else {
              // Current version is lower than the latest version
              emit(VersionOutdated());
            }
          }
        },
      );
    });
  }
}
