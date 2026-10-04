import 'package:data/utils/validate_id_number.dart';
import 'package:either_dart/either.dart';
import 'package:data/auth/data_source/profile_data_source.dart';
import 'package:data/auth/models/profile.dart';
import 'auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:data/utils/eesup_exception.dart';

class ProfileRepository {
  final AuthRepository _authRepository;
  final ProfileDataSource _profileDataSource;

  ProfileRepository(this._authRepository, this._profileDataSource);

  ///Fetches the profile of the user with the given [id]
  Future<Either<EESUpException, Profile?>> fetchSessionProfile() async {
    final result = await _authRepository.executeFutureWithAuth((id) async {
      final profile = await _profileDataSource.fetchProfile(id);
      return profile;
    });
    return result;
  }

  Future<Either<EESUpException, bool>> deactivateAccount() async {
    final result = await _authRepository.executeFutureWithAuth((id) async {
      final deleted = await _profileDataSource.deactivateAccount(id);
      if (deleted) {
        await _authRepository.signOut();
      }
      return deleted;
    });
    return result;
  }

  Future<Either<EESUpException, bool>> changePhone(String phone) async {
    final result = await _authRepository.executeFutureWithAuth((id) async {
      final res = await _profileDataSource.changePhone(id);
      return res;
    });
    return result;
  }

  ///previoudId is the id of the profile before it was updated
  ///TODO:JUST A TEMPORARY FIX FOR THE ID NUMBER VALIDATION
  ///
  /// When [original] (the profile as it was before editing) is given, only
  /// the fields that changed are written, so saving one field from a stale
  /// copy of the profile can't put old values (e.g. an old phone number)
  /// back over newer ones.
  Future<Either<EESUpException, bool>> updateProfile(
    Profile profile,
    String? prevIdNumber, {
    Profile? original,
  }) async {
    final idNumber = profile.rsaIdNumber;

    if (idNumber != null && idNumber != prevIdNumber) {
      final isValid = isValidSouthAfricanID(idNumber);

      if (kDebugMode) {
        print('ID Number: $idNumber, isValid: $isValid');
      }

      if (!isValid) {
        // If ID is not valid, return an error.
        return Left(EESUpException(
          message: 'Invalid South African ID Number.',
        ));
      }

      final isUsedResult = await _authRepository.idNumberExists(idNumber);

      return isUsedResult.fold(
          (l) => Left(EESUpException(
              message: 'Failed to verify id number, Please try again.')),
          (r) async {
        if (!r) {
          return _save(profile, original);
        } else {
          return Left(
            EESUpException(
              message: 'ID Number is already in use by another user.',
            ),
          );
        }
      });
    } else {
      return _save(profile, original);
    }
  }

  Future<Either<EESUpException, bool>> _save(
    Profile profile,
    Profile? original,
  ) {
    return _authRepository.executeFutureWithAuth((id) {
      if (original == null) return _profileDataSource.updateProfile(profile);
      final before = original.toJson();
      final changed = Map<String, dynamic>.fromEntries(
        profile.toJson().entries.where((e) => before[e.key] != e.value),
      );
      return _profileDataSource.updateProfileFields(profile.userId, changed);
    });
  }

  Future<Either<EESUpException, bool>> checkIdNumber() async {
    final result = await _authRepository.executeFutureWithAuth((id) async {
      Profile? profile = await _profileDataSource.fetchProfile(id);
      if (profile == null ||
          profile.rsaIdNumber == null ||
          profile.rsaIdNumber!.isEmpty) {
        return false;
      }
      return true;
    });

    return result.fold(
      (l) => Left(
          EESUpException(message: 'Error fetching or checking ID number.')),
      (r) => Right(r),
    );
  }

  Future<Either<EESUpException, bool>> checkIfHasAddress() async {
    final result = await _authRepository.executeFutureWithAuth((id) async {
      final hasAddress = await _profileDataSource.checkIfhasAddress(id);
      return hasAddress;
    });

    return result.fold(
      (l) => Left(EESUpException(message: 'Error checking address status.')),
      (r) => Right(r),
    );
  }

  Future<Either<EESUpException, Map<String, dynamic>?>>
      checkCurrentAppVersion() async {
    try {
      final version = await _profileDataSource.checkCurrentAppVersion();
      return Right(version);
    } catch (e) {
      return Left(EESUpException(message: 'Error checking app version: $e'));
    }
  }
}
