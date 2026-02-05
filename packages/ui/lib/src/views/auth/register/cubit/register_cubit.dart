import 'package:bloc/bloc.dart';
import 'package:data/auth/repository/auth_repository.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:ui/src/views/auth/register/cubit/register_form.dart';

class RegisterCubit extends Cubit<RegisterForm> {
  final AuthRepository _authRepository;
  bool _isSubmitting = false;

  RegisterCubit(this._authRepository) : super(RegisterForm.initial());

  void updateForm(RegisterForm form) => emit(form);

  Future<void> submit() async {
    // Prevent double submission
    if (_isSubmitting) return;
    _isSubmitting = true;

    // Reset status before starting
    emit(state.copyWith(
      isLoading: true,
      status: RegisterStatus.init,
      errorMessage: null,
    ));

    final results = await _authRepository.signUp(
      email: state.email,
      phone: state.phone,
      password: state.password!,
      metaData: state.toJson(),
    );

    _isSubmitting = false;
    emit(state.copyWith(isLoading: false));

    results.fold((left) {
      emit(
        state.copyWith(
          status: RegisterStatus.failed,
          errorMessage: left.message,
        ),
      );
    }, (right) {
      if (right) {
        emit(state.copyWith(
          status: RegisterStatus.awaitingOtp,
          errorMessage: null,
        ));
      } else {
        emit(
          state.copyWith(
            status: RegisterStatus.failed,
            errorMessage:
                'Something went wrong while processing your request.',
          ),
        );
      }
    });
  }

  /// Returns Either with error (Left) or exists boolean (Right)
  /// This allows UI to distinguish between network errors and actual existence check
  Future<Either<EESUpException, bool>> emailExistsResult(String email) async {
    emit(state.copyWith(isLoading: true));
    final results = await _authRepository.emailExists(email);
    emit(state.copyWith(isLoading: false));
    return results;
  }

  /// Returns Either with error (Left) or exists boolean (Right)
  /// This allows UI to distinguish between network errors and actual existence check
  Future<Either<EESUpException, bool>> phoneExistsResult(String phone) async {
    emit(state.copyWith(isLoading: true));
    final results = await _authRepository.phoneExists(phone);
    emit(state.copyWith(isLoading: false));
    return results;
  }

  /// Legacy method - returns true on error (blocks registration)
  /// Consider using emailExistsResult for better error handling
  Future<bool> emailExists(String email) async {
    final results = await emailExistsResult(email);
    return results.fold((l) => true, (r) => r);
  }

  /// Legacy method - returns true on error (blocks registration)
  /// Consider using phoneExistsResult for better error handling
  Future<bool> phoneExists(String phone) async {
    final results = await phoneExistsResult(phone);
    return results.fold((l) => true, (r) => r);
  }
}
