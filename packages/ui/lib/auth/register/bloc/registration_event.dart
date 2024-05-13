part of 'registration_bloc.dart';

@immutable
sealed class RegistrationEvent {}

final class SignUpFormUpdated extends RegistrationEvent {
  final SignUpForm signUpForm;
  SignUpFormUpdated(this.signUpForm);
}

final class SignUpFormSubmitted extends RegistrationEvent {}
