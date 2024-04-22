import 'package:supabase_flutter/supabase_flutter.dart';

abstract class IAuthDataSource {
  /// Sign in with email and password
  /// - [email] is the email address of the user
  /// - [password] is the password of the user
  /// - [phone] is the phone number of the user
  /// - [return] is the result of the authentication
  Future<bool> signIn({
    String? email,
    String? phone,
    required String password,
  });

  Future<bool> signInAnon();

  Stream<AuthState> get authStateChanges;

  Future<bool> isActive(String id);

  ///Remove the current session of the user
  ///And then sign out
  Future<bool> signOut();

  /// Get the current user id
  /// - [return] is the user id
  /// - [return] is null if the user is not authenticated
  String? get sessionId;

  ///Checks if the given email is already registered or not
  ///
  Future<bool> isEmailRegistered(String email);

  ///Checks if the given phone number is already registered or not
  ///
  Future<bool> isPhoneRegistered(String phone);

  ///Checks if the given id number belongs to another user
  ///
  Future<bool> isIdNumberRegistered(String idNumber);

  ///Checks if the given ID number is a valid South African ID number
  ///Using an external API
  Future<bool> isValidRSAID({required String id, required String apiKey});

  ///Checks if the given referral code is valid or not
  ///
  ///And returns a record of is valid and the role of the user
  Future<({bool isValid, bool isCorporate})> isValidReferralCode(int code);

  /// Sign up with email and password
  /// - [email] is the email address of the user
  /// - [password] is the password of the user
  /// - [phone] is the phone number of the user
  /// - [data] the meta data which has the user's first name and last name
  Future<bool> signUp({
    String? email,
    String? phone,
    required String password,
    required Map<String, dynamic> data,
  });

  ///Verifies a given OTP either by email or phone
  ///
  Future<bool> verifyOtp({
    String? email,
    String? phone,
    required String otp,
    required OtpType type,
  });

  Future<bool> resendOtp({
    String? email,
    String? phone,
    required OtpType type,
  });

  ///Once the otp is verified, the user can change their password
  ///using this method
  ///
  Future<bool> updatePassword({
    String? email,
    String? phone,
    required String newPassword,
  });

  Future<bool> resetPasswordWithEmail(String email);

  Future<bool> resetPasswordWithPhone(String phone);
}
