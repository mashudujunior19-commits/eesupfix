import 'package:bloc/bloc.dart';
import 'package:data_sources/auth/models/profile.dart';
import 'package:email_validator/email_validator.dart';
import 'package:meta/meta.dart';
import 'package:repository/auth/profile_repository.dart';
import 'package:repository/utils/eesup_exception.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final ProfileRepository _repository;
  EditProfileBloc(this._repository) : super(EditProfileLoading()) {
    on<EditProfileInitialized>((event, emit) {
      emit(CurrentProfileForm(event.profile));
    });
    on<ProfileEdited>((event, emit) {
      emit(CurrentProfileForm(event.profile));
    });

    on<PhoneVerificationStarted>((event, emit) async {
      final results =
          await _repository.changePhone(event.currentProfile.phone!);
      print(results);
    });

    on<ProfileSaved>((event, emit) async {
      if (state is CurrentProfileForm) {
        final profile = (state as CurrentProfileForm).profile;

        emit(EditProfileLoading());
        final results = await _repository.updateProfile(
          profile,
          event.idNumber,
        );

        results.fold((left) {
          emit(ProfileEditingError(left));
        }, (right) {
          if (right) {
            emit(ProfileSavingSuccess());
          } else {
            emit(
              ProfileEditingError(
                EESUpException(
                  message: 'Something went wrong, please try again later',
                ),
              ),
            );
          }
        });
      }
    });
  }
}
