part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}

final class EditProfileInitialized extends EditProfileEvent {
  final Profile profile;
  EditProfileInitialized(this.profile);
}

final class ProfileEdited extends EditProfileEvent {
  final Profile profile;
  ProfileEdited(this.profile);
}

final class ProfileSaved extends EditProfileEvent {
  final String? idNumber;
  ProfileSaved(this.idNumber);
}

final class PhoneVerificationStarted extends EditProfileEvent {
  final Profile currentProfile;
  PhoneVerificationStarted(this.currentProfile);
}
