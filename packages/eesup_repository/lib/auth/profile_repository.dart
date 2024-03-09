import 'package:dartz/dartz.dart';
import 'package:eesup_data_source/auth/data_source/profile_data_source.dart';
import 'package:eesup_data_source/auth/models/profile.dart';
import 'package:eesup_repository/core/eesup_exception.dart';
import 'package:eesup_repository/core/validate_id_number.dart';
import 'auth_repository.dart';
import 'package:flutter/foundation.dart';

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


  ///previoudId is the id of the profile before it was updated
  ///TODO:JUST A TEMPORARY FIX FOR THE ID NUMBER VALIDATION
  Future<Either<EESUpException, bool>> updateProfile(
    Profile profile,
    String prevId,
  ) async {
    final idNumber = profile.rsaIdNumber;

    if (idNumber != null && idNumber != prevId) {
      final isValid = isValidSouthAfricanID(idNumber);

      if (kDebugMode) {
        print('ID Number: $idNumber, isValid: $isValid');
      }

      if (!isValid) {
        // If ID is not valid, return an error.
        return left(EESUpException(
          message: 'Invalid South African ID Number.',
        ));
      }

      final isUsedResult = await _authRepository.idNumberExists(idNumber);

      return isUsedResult.fold(
          (l) => Left(EESUpException(
              message: 'Failed to verify id number, Please try again.')),
          (r) async {
        if (!r) {
          final result =
              await _authRepository.executeFutureWithAuth((id) async {
            final updated = await _profileDataSource.updateProfile(profile);
            return updated;
          });
          return result;
        } else {
          return left(
            EESUpException(
                message: 'ID Number is already in use by another user.'),
          );
        }
      });
    } else {
      final result = await _authRepository.executeFutureWithAuth((id) async {
        final updated = await _profileDataSource.updateProfile(profile);
        return updated;
      });
      return result;
    }
  }
}
