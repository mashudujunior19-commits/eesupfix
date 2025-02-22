part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileLoading extends EditProfileState {}

final class ProfileSavingSuccess extends EditProfileState {}

final class ProfileEditingError extends EditProfileState {
  final Profile profile;
  final EESUpException error;
  ProfileEditingError(this.profile, this.error);
}

final class CurrentProfileForm extends EditProfileState {
  final Profile profile;
  CurrentProfileForm(this.profile);

  bool pendingPhoneVerification(String? oldPhone) {
    if (oldPhone != profile.phone) {
      return true;
    }
    return false;
  }

  bool pendingEmailVerification(String? oldEmail) {
    if (oldEmail != profile.email) {
      if (EmailValidator.validate(profile.email!)) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}

class AddressMissingState extends EditProfileState {}

class AddressCheckError extends EditProfileState {
  final EESUpException error;
  AddressCheckError(this.error);
}
