import 'package:data_sources/auth/models/user_role.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up.freezed.dart';

@freezed
class SignUp with _$SignUp {
  const factory SignUp({
    String? email,
    String? phone,
    required String password,
    required UserRole? role,
    String? firstName,
    String? lastName,
    int? referralCode,
    required bool? isCorp,
    String? idNumber,
    String? corpName,
    String? corpReg,
    String? npcReg,
    required bool isAgreed,
    required bool isRSACitizen,
    DateTime? dob,
  }) = _SignUp;
}
