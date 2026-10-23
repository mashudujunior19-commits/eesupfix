import 'package:supabase_flutter/supabase_flutter.dart';

enum SocialProvider { google, apple }

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

  /// Starts the Google or Apple OAuth flow. Returns true once the provider
  /// page was opened; the session itself arrives through [authStateChanges]
  /// when the provider redirects back to the app.
  Future<bool> signInWithProvider(SocialProvider provider);

  /// Whether [userId] finished registering with Towris: an individual needs a
  /// first name, last name and ID number; a corporate account needs a
  /// corporate name. Social sign-in is only allowed for such accounts.
  Future<bool> hasCompletedRegistration(String userId);

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

  /// Marks that a password reset is in progress on the current (recovery)
  /// session, so the app can tell a live password-recovery session apart
  /// from a normal signed-in one -- including after the app is killed and
  /// relaunched with that session restored from storage. Stored in
  /// `user_metadata` (not locally) so it survives a cold restart and
  /// follows the account across devices.
  Future<bool> markPasswordResetPending();

  /// Clears the pending-password-reset marker -- called once the password
  /// is actually changed, or if the user abandons a resumed reset.
  Future<bool> clearPasswordResetPending();

  Future<String?> fetchSystemIssue();
}
