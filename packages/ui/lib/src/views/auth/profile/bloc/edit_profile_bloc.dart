import 'package:bloc/bloc.dart';
import 'package:data/auth/models/profile.dart';
import 'package:data/auth/repository/profile_repository.dart';
import 'package:data/utils/localize_south_african_phone.dart';
import 'package:email_validator/email_validator.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final ProfileRepository _repository;

  /// The profile as last loaded/saved, so a save only writes what changed.
  Profile? _original;

  EditProfileBloc(this._repository) : super(EditProfileLoading()) {
    on<EditProfileInitialized>((event, emit) {
      _original = event.profile;
      emit(CurrentProfileForm(event.profile));
    });
    on<ProfileEdited>((event, emit) {
      emit(CurrentProfileForm(event.profile));
    });

    // on<PhoneVerificationStarted>((event, emit) async {
    //   final results =
    //       await _repository.changePhone(event.currentProfile.phone!);
    // });

    on<ProfileSaved>((event, emit) async {
      if (state is CurrentProfileForm) {
        final current = state as CurrentProfileForm;
        final profile = current.profile;

        final phone = profile.phone;
        if (phone != null && localizeSAPhoneNumber(phone) != phone) {
          emit(ProfileEditingError(
            profile,
            EESUpException(message: 'Enter a valid South African phone number.'),
          ));
          return;
        }

        emit(EditProfileLoading());
        final results = await _repository.updateProfile(
          profile,
          event.idNumber,
          original: _original,
        );

        results.fold((left) {
          emit(ProfileEditingError(profile, left));
        }, (right) {
          if (right) {
            _original = profile;
            emit(ProfileSavingSuccess());
          } else {
            emit(
              ProfileEditingError(
                profile,
                EESUpException(
                  message: 'Something went wrong, please try again later',
                ),
              ),
            );
          }
        });
      }
    });
    on<ProfileFormReset>((event, emit) {
      emit(CurrentProfileForm(event.currentProfile));
    });

    on<CheckIfHasAddress>((event, emit) async {
      emit(EditProfileLoading());

      final result = await _repository.checkIfHasAddress();

      result.fold(
        (left) {
          emit(AddressCheckError(left));
        },
        (hasAddress) {
          if (hasAddress) {
            emit(ProfileSavingSuccess());
          } else {
            emit(AddressMissingState());
          }
        },
      );
    });
  }
}
