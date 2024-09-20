import 'package:bloc/bloc.dart';
import 'package:data/auth/repository/auth_repository.dart';
import 'package:ui/src/views/auth/register/cubit/register_form.dart';

class RegisterCubit extends Cubit<RegisterForm> {
  final AuthRepository _authRepository;
  RegisterCubit(this._authRepository) : super(RegisterForm.initial());

  void updateForm(RegisterForm form) => emit(form);

  Future<void> submit() async {
    emit(state.copyWith(isLoading: true));
    final results = await _authRepository.signUp(
      email: state.email,
      phone: state.phone,
      password: state.password!,
      metaData: state.toJson(),
    );
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
                'Something went wrong while proccessing your request.',
          ),
        );
      }
    });
  }

  Future<bool> emailExists(String email) async {
    emit(state.copyWith(isLoading: true));
    final results = await _authRepository.emailExists(email);
    emit(state.copyWith(isLoading: false));
    bool exists = false;

    results.fold((l) {
      exists = true;
    }, (r) {
      exists = r;
    });
    return exists;
  }

  Future<bool> phoneExists(String phone) async {
    emit(state.copyWith(isLoading: true));
    final results = await _authRepository.phoneExists(phone);
    emit(state.copyWith(isLoading: false));
    bool exists = false;

    results.fold((l) {
      exists = true;
    }, (r) {
      exists = r;
    });
    return exists;
  }
}
