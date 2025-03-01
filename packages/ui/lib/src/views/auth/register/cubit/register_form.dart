import 'package:dart_mappable/dart_mappable.dart';
import 'package:data/utils/validate_id_number.dart';
import 'package:email_validator/email_validator.dart';

part 'register_form.mapper.dart';

@MappableClass(generateMethods: GenerateMethods.equals | GenerateMethods.copy)
class RegisterForm with RegisterFormMappable {
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
  final bool isLoading;
  final RegisterStatus status;
  final String? errorMessage;

  RegisterForm({
    this.firstName,
    this.lastName,
    this.idNumber,
    this.dob,
    this.corpName,
    this.corpReg,
    this.npcCorpReg,
    this.email,
    this.phone,
    this.referralCode,
    this.password,
    this.retypedPassword,
    this.errorMessage,
    required this.isRSACitizen,
    required this.isPasswordValid,
    required this.isLoading,
    required this.status,
    required this.agreedToTcsAndCs,
    required this.isCorp,
  });

  factory RegisterForm.initial() => RegisterForm(
        isCorp: false,
        agreedToTcsAndCs: false,
        isRSACitizen: true,
        isPasswordValid: false,
        isLoading: false,
        status: RegisterStatus.init,
      );

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

  // DateTime _extractDateOfBirth(String idNumber) {
  //   // Extract the date of birth from the ID number
  //   String year = idNumber.substring(0, 2);
  //   String month = idNumber.substring(2, 4);
  //   String day = idNumber.substring(4, 6);
  //   // Construct the date of birth string in the format yyyy-mm-dd
  //   String d = '$year-$month-$day';
  //   final date = DateFormat('yy-MM-dd').parse(d);
  //   return date;
  // }
  DateTime _extractDateOfBirth(String idNumber) {
    String year = idNumber.substring(0, 2);
    String month = idNumber.substring(2, 4);
    String day = idNumber.substring(4, 6);

    // Infer the century based on the year
    int currentYear = DateTime.now().year % 100;
    int century = int.parse(year) <= currentYear ? 2000 : 1900;

    // Combine the inferred year, month, and day
    String fullYear = (century + int.parse(year)).toString();
    return DateTime(int.parse(fullYear), int.parse(month), int.parse(day));
  }

  int _calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;

    // Adjust for birthdays not yet occurred this year
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
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

enum RegisterStatus {
  awaitingOtp,
  failed,
  success,
  init,
}
