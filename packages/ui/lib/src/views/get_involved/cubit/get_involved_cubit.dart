import 'package:bloc/bloc.dart';
import 'package:data/get_involved/repository/get_involved_repository.dart';
import 'package:ui/src/views/get_involved/cubit/get_involved_form.dart';

class GetInvolvedCubit extends Cubit<GetInvolvedForm> {
  final GetInvolvedRepository _getInvolvedRepository;
  bool _isSubmitting = false;

  GetInvolvedCubit(this._getInvolvedRepository)
      : super(GetInvolvedForm.initial());

  void updateForm(GetInvolvedForm form) => emit(form);

  Future<void> submit() async {
    if (_isSubmitting) return;
    _isSubmitting = true;

    emit(state.copyWith(isLoading: true, errorMessage: null));

    final results = await _getInvolvedRepository.submitApplication(
      state.toApplication(),
    );

    _isSubmitting = false;
    emit(state.copyWith(isLoading: false));

    results.fold((left) {
      emit(
        state.copyWith(
          status: GetInvolvedSubmitStatus.failed,
          errorMessage: left.message,
        ),
      );
    }, (right) {
      emit(state.copyWith(status: GetInvolvedSubmitStatus.success));
    });
  }
}
