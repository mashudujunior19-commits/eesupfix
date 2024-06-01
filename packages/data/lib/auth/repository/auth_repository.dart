import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:data/auth/data_source/abstract_auth_data_source.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final IAuthDataSource supaSource;

  AuthRepository({required this.supaSource});

  Stream<AuthState> get authStateChanges => supaSource.authStateChanges;

  Future<Either<EESUpException, bool>> signInEmail({
    required String email,
    required String password,
  }) async {
    final emailValid = EmailValidator.validate(email);
    if (!emailValid) {
      return Left(EESUpException(message: 'Invalid email address.'));
    }

    if (password.isEmpty) {
      return Left(EESUpException(message: 'Password cannot be empty.'));
    }

    final result = await EESUpException.guardFuture(action: () async {
      final res = await supaSource.signIn(
        email: email,
        password: password,
      );
      return res;
    });

    return result;
  }

  Future<Either<EESUpException, bool>> signIn({
    String? email,
    String? phone,
    required String password,
  }) async {
    //validate email
    final validationResult = validatePhoneEmail(email, phone);

    return validationResult.fold(
      (l) {
        return Left(l);
      },
      (r) async {
        final result = await EESUpException.guardFuture(action: () async {
          final res = await supaSource.signIn(
            email: email,
            phone: phone,
            password: password,
          );

          return res;
        });

        ///If the user is not found, we return false
        return result.fold((ex) => Left(ex), (success) async {
          if (success) {
            final isActive = await executeFutureWithAuth((id) {
              return supaSource.isActive(id);
            });

            return isActive.fold((l) async {
              await OneSignal.logout();
              await signOut();
              return Left(
                EESUpAuthException(
                    message: 'Your account has been deactivated.'),
              );
            }, (r) async {
              if (r) {
                //set one signal id
                return const Right(true);
              } else {
                await signOut();
                return Left(
                  EESUpAuthException(
                      message: 'Your account has been deactivated.'),
                );
              }
            });
          } else {
            return Left(
              EESUpAuthException(message: 'Invalid credentials'),
            );
          }
        });
      },
    );
  }

  Future<Either<EESUpException, bool>> signInAnon() async {
    final results = await EESUpException.guardFuture(
      action: () => supaSource.signInAnon(),
    );
    return results;
  }

  Future<Either<EESUpException, bool>> signUp({
    String? email,
    String? phone,
    required String password,
    required Map<String, dynamic> metaData,
  }) async {
    //validate email
    final validationResult = validatePhoneEmail(email, phone);
    //sign up
    return validationResult.fold((l) {
      return Left(l);
    }, (r) async {
      final result = await EESUpException.guardFuture(action: () async {
        final res = await supaSource.signUp(
          email: email,
          phone: phone,
          password: password,
          data: metaData,
        );
        return res;
      });

      return result;
    });
  }

  Future<Either<EESUpException, bool>> resendOtp({
    String? email,
    String? phone,
    required OtpType type,
  }) async {
    final results = await EESUpException.guardFuture(
      action: () => supaSource.resendOtp(
        type: type,
        email: email,
        phone: phone,
      ),
    );
    return results;
  }

  Future<bool> verifyOtp({
    String? email,
    String? phone,
    required String otp,
    required OtpType type,
  }) async {
    try {
      final res = await supaSource.verifyOtp(
        email: email,
        phone: phone,
        otp: otp,
        type: type,
      );
      return res;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Either<EESUpException, String> validatePhoneEmail(
      String? email, String? phone) {
    //validate email
    if (email != null) {
      final isValidEmail = EmailValidator.validate(email);
      if (!isValidEmail) {
        return Left(EESUpException(message: 'Invalid email address.'));
      }
      return Right(email);
    } else if (phone != null) {
      // phone = _getPhoneWithRSACode(phone);
      // if (phone == null) {
      //   return Left(EESUpException(message: 'Invalid phone number'));
      // }
      return Right(phone);
    } else {
      return Left(
        EESUpException(
          message: 'You must provide either an email or phone.',
        ),
      );
    }
  }

  Future<Either<EESUpException, ({bool isValid, bool isCorporate})>>
      isValidReferralCode(int code) async {
    final result = await EESUpException.guardFuture(action: () async {
      final res = await supaSource.isValidReferralCode(code);
      return res;
    });
    return result;
  }

  Future<Either<EESUpException, bool>> emailExists(String? email) async {
    final validationResult = validatePhoneEmail(email, null);
    return validationResult.fold(
      (l) {
        return Left(l);
      },
      (r) async {
        final result = await EESUpException.guardFuture(action: () async {
          final res = await supaSource.isEmailRegistered(r);
          return res;
        });
        return result;
      },
    );
  }

  Future<Either<EESUpException, bool>> phoneExists(String? phone) async {
    final validationResult = validatePhoneEmail(null, phone);
    return validationResult.fold(
      (l) {
        return Left(l);
      },
      (r) async {
        final result = await EESUpException.guardFuture(action: () async {
          final res = await supaSource.isPhoneRegistered(r);
          return res;
        });
        return result;
      },
    );
  }

  Future<Either<EESUpException, bool>> idNumberExists(String idNumber) async {
    final result = await EESUpException.guardFuture(action: () async {
      final res = await supaSource.isIdNumberRegistered(idNumber);
      return res;
    });
    return result;
  }

  bool isValidRSAPhone(String phone) {
    final RegExp phoneRegex = RegExp(r'^(0[0-9]{9}|27[0-9]{9})$');
    return phoneRegex.hasMatch(phone);
  }

  String? get sessionId => supaSource.sessionId;

  /// Executes the provided [action] and ensures that the user is logged in.
  ///
  Future<Either<EESUpException, T>> executeWithSession<T>(
    Future<T> Function(String session) action,
  ) async {
    final id = sessionId;
    if (id == null) {
      return Left(EESUpAuthException(message: 'You are not logged in'));
    }
    final result = await action(id);
    return Right(result);
  }

  Future<Either<EESUpException, bool>> signOut() async {
    final result = await EESUpException.guardFuture(action: () async {
      final res = await supaSource.signOut();
      return res;
    });
    return result;
  }

  /// Executes the provided future [action] and ensures that the user is logged in.
  ///
  /// If the user is not logged in, the action is not executed and a [Left] is returned.
  ///
  Future<Either<EESUpException, T>> executeFutureWithAuth<T>(
    Future<T> Function(String id) action,
  ) async {
    if (sessionId == null) {
      return Left(EESUpAuthException(message: 'You must be signed in.'));
    }

    final result = await EESUpException.guardFuture(
      action: () => action(sessionId!),
    );
    return result.fold((ex) => Left(ex), (value) => Right(value));
  }

  /// Executes the provided stream [action] and ensures that the user is logged in.
  ///
  /// If the user is not logged in, the action is not executed and a [Left] is returned.
  ///
  Stream<Either<EESUpException, T>> executeStreamWithAuth<T>(
    Stream<T> Function(String id) action,
  ) async* {
    if (sessionId == null) {
      yield Left(EESUpAuthException(message: 'You must be signed in.'));
    }

    Stream<Either<EESUpException, T>> stream = EESUpException.guardStream(
      action: () => action(sessionId!),
    );

    await for (var event in stream) {
      yield event;
    }
  }

  /// Executes the provided  [action] and ensures that the user is logged in.
  ///
  /// If the user is not logged in, the action is not executed and a [Left] is returned.
  ///
  Either<EESUpException, T> executeWithAuth<T>(T Function(String id) action) {
    if (sessionId == null) {
      return Left(EESUpAuthException(message: 'You must be signed in.'));
    }

    final result = EESUpException.guardValue(
      action: () => action(sessionId!),
    );
    return result.fold((ex) => Left(ex), (value) => Right(value));
  }

  Future<Either<EESUpException, bool>> resetPasswordWithEmail(
      String email) async {
    final results = await EESUpException.guardFuture(action: () async {
      final res = await supaSource.resetPasswordWithEmail(email);
      return res;
    });
    return results.fold((l) => const Right(false), (r) => const Right(true));
  }

  Future<Either<EESUpException, bool>> resetPasswordWithPhone(
      String phone) async {
    final results = await EESUpException.guardFuture(action: () async {
      final res = await supaSource.resetPasswordWithPhone(phone);
      return res;
    });
    return results.fold((l) => const Right(false), (r) => const Right(true));
  }

  Future<Either<EESUpException, bool>> updatePassword(
    String password, {
    String? email,
    String? phone,
  }) async {
    final results = await EESUpException.guardFuture(action: () async {
      final res = await supaSource.updatePassword(
        email: email,
        phone: phone,
        newPassword: password,
      );
      return res;
    });
    return results;
  }

  Future<String?> fetchSystemIssue() async {
    final res = await supaSource.fetchSystemIssue();
    return res;
  }
}
