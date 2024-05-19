part of 'registration_bloc.dart';

@immutable
sealed class RegistrationFormState {}

final class AwaitingOtpAuth extends RegistrationFormState {
  final SignUpForm oldForm;
  AwaitingOtpAuth(this.oldForm);
}

final class FailedToSignUp extends RegistrationFormState {
  final EESUpException err;
  final SignUpForm oldForm;
  FailedToSignUp(this.oldForm, this.err);
}

final class SignUpLoading extends RegistrationFormState {}

final class SignUpForm extends RegistrationFormState {
  final String? firstName;
  final String? lastName;
  final String? idNumber;
  final DateTime? dob;
  final bool isCorp;
  final String? corpName;
  final String? corpReg;
  final String? npcCorpReg;
  final String? email;
  final String? phone;
  final int? referralCode;
  final bool agreedToTcsAndCs;
  final String? password;
  final String? retypedPassword;
  final bool isRSACitizen;
  final bool isPasswordValid;

  SignUpForm({
    this.isCorp = false,
    this.agreedToTcsAndCs = false,
    this.isRSACitizen = true,
    this.isPasswordValid = true,
    this.corpName,
    this.corpReg,
    this.email,
    this.phone,
    this.referralCode,
    this.password,
    this.retypedPassword,
    this.firstName,
    this.lastName,
    this.dob,
    this.idNumber,
    this.npcCorpReg,
  });

  // ignore: unused_element
  bool _isValidEmail() {
    if (email == null) return false;
    return EmailValidator.validate(email.toString());
  }

  bool isValidIdNumber() {
    if (idNumber == null) return false;
    return isValidSouthAfricanID(idNumber.toString());
  }

  bool isOfAge() {
    if (idNumber == null && isRSACitizen) {
      return false;
    }

    if (dob == null && !isRSACitizen) {
      return false;
    }

    int age = 0;
    if (isRSACitizen) {
      final d = _extractDateOfBirth(idNumber!);
      age = DateTime.now().year - d.year;
    } else {
      age = DateTime.now().year - dob!.year;
    }
    return age >= 18;
  }

  DateTime _extractDateOfBirth(String idNumber) {
    // Extract the date of birth from the ID number
    String year = idNumber.substring(0, 2);
    String month = idNumber.substring(2, 4);
    String day = idNumber.substring(4, 6);
    // Construct the date of birth string in the format yyyy-mm-dd
    String d = '$year-$month-$day';
    final date = DateFormat('yy-MM-dd').parse(d);
    return date;
  }

  Map<String, dynamic> toJson() {
    if (isCorp) {
      return {
        'corp_name': _capitalizeFirstLetter(corpName ?? ''),
        'corp_reg': corpReg,
        'npc_reg': null,
        'type': 'Corporate',
        'is_corp': isCorp,
        'referral_code': referralCode,
      };
    } else {
      return {
        'first_name': _capitalizeFirstLetter(firstName ?? ''),
        'last_name': _capitalizeFirstLetter(lastName ?? ''),
        'id_number': idNumber,
        'referral_code': referralCode,
        'is_corp': isCorp,
      };
    }
  }

  String? _capitalizeFirstLetter(String str) {
    if (str.isEmpty) return null;
    return str[0].toUpperCase() + str.substring(1);
  }
}
