import 'package:bloc/bloc.dart';
import 'package:data/organisation/repository/organisation_repository.dart';
import 'package:ui/src/views/organisation/cubit/organisation_form.dart';

class OrganisationCubit extends Cubit<OrganisationForm> {
  final OrganisationRepository _organisationRepository;
  bool _isSubmitting = false;

  OrganisationCubit(this._organisationRepository)
      : super(OrganisationForm.initial());

  void updateForm(OrganisationForm form) => emit(form);

  Future<void> submit() async {
    if (_isSubmitting) return;
    _isSubmitting = true;

    emit(state.copyWith(isLoading: true, errorMessage: null));

    final results = await _organisationRepository.registerOrganisation(
      state.toOrganisation(),
    );

    _isSubmitting = false;
    emit(state.copyWith(isLoading: false));

    results.fold((left) {
      emit(
        state.copyWith(
          status: OrganisationSubmitStatus.failed,
          errorMessage: left.message,
        ),
      );
    }, (right) {
      emit(state.copyWith(status: OrganisationSubmitStatus.success));
    });
  }
}
