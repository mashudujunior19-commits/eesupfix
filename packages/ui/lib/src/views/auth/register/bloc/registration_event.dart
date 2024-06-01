part of 'registration_bloc.dart';

@immutable
sealed class RegistrationEvent {}

final class SignUpRestarted extends RegistrationEvent {
  final SignUpForm form;
  SignUpRestarted(this.form);
}

final class CorpFormUpdated extends RegistrationEvent {
  final String? name;
  final String? reg;
  CorpFormUpdated({required this.name, required this.reg});
}

final class IndividualFormUpdated extends RegistrationEvent {
  final String? firstName;
  final String? lastName;
  final String? idNumber;
  final DateTime? dob;
  final bool isRSACitizen;

  IndividualFormUpdated({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.isRSACitizen,
    required this.idNumber,
  });
}

final class AccountTypeUpdated extends RegistrationEvent {
  final bool isCorp;
  AccountTypeUpdated(this.isCorp);
}

final class SignUpSubmited extends RegistrationEvent {
  final SignUpForm form;
  SignUpSubmited(this.form);
}

final class ReferralCodeUpdated extends RegistrationEvent {
  final int? code;
  final bool acceptedTsAndCs;
  ReferralCodeUpdated({required this.code, required this.acceptedTsAndCs});
}

final class CredentialsUpdated extends RegistrationEvent {
  final String? email;
  final String? phone;
  final String? password;
  final String? retypedPassword;

  CredentialsUpdated({
    this.email,
    this.phone,
    this.password,
    this.retypedPassword,
  });
}
