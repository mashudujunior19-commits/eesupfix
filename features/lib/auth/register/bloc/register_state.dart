part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterFormState extends RegisterState {
  final String? firstName;
  final String? lastName;
  final String? idNumber;
  final DateTime? dob;
  final bool isCorp;
  final String? corpName;
  final String? corpReg;
  final String? email;
  final String? phone;
  final int? referralCode;
  final bool agreedToTcsAndCs;
  final String? password;
  final String? retypedPassword;

  RegisterFormState({
    this.isCorp = false,
    this.corpName,
    this.corpReg,
    this.email,
    this.phone,
    this.referralCode,
    this.agreedToTcsAndCs = false,
    this.password,
    this.retypedPassword,
    this.firstName,
    this.lastName,
    this.dob,
    this.idNumber,
  });

  RegisterFormState copyWith({
    bool? isCorp,
    String? corpName,
    String? corpReg,
    String? email,
    String? phone,
    int? referralCode,
    bool? agreedToTcsAndCs,
    String? password,
    String? retypedPassword,
    String? firstName,
    String? lastName,
    String? idNumber,
    DateTime? dob,
  }) {
    return RegisterFormState(
      isCorp: isCorp ?? this.isCorp,
      corpName: corpName ?? this.corpName,
      corpReg: corpReg ?? this.corpReg,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      referralCode: referralCode ?? this.referralCode,
      agreedToTcsAndCs: agreedToTcsAndCs ?? this.agreedToTcsAndCs,
      password: password ?? this.password,
      retypedPassword: retypedPassword ?? this.retypedPassword,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dob: dob ?? this.dob,
      idNumber: idNumber ?? this.idNumber,
    );
  }

  bool isPasswordValid() {
    if (password == null) return false;
    if (retypedPassword == null) return false;
    if (password != retypedPassword) return false;
    return true;
  }

  bool isValidEmail() {
    if (email == null) return false;
    return EmailValidator.validate(email.toString());
  }

  bool isValidIdNumber() {
    if (idNumber == null) return false;
    return isValidSouthAfricanID(idNumber.toString());
  }
}
