import 'package:data/auth/data_source/abstract_auth_data_source.dart';
import 'package:data/auth/models/user_role.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthSupabaseDataSource implements IAuthDataSource {
  final SupabaseClient _client;

  AuthSupabaseDataSource({
    required SupabaseClient client,
  }) : _client = client;
  @override
  Future<bool> isEmailRegistered(String email) async {
    final table = _client.from('profile');
    final res = await table.select('email').eq('email', email.trim());
    return res.isNotEmpty;
  }

  @override
  Future<bool> isIdNumberRegistered(String idNumber) async {
    final table = _client.from('profile');
    final res =
        await table.select('rsa_id_number').eq('rsa_id_number', idNumber);
    return res.isNotEmpty;
  }

  @override
  Future<bool> isPhoneRegistered(String phone) async {
    final table = _client.from('profile');
    final res = await table.select('phone').eq('phone', phone);
    return res.isNotEmpty;
  }

  @override
  Future<({bool isValid, bool isCorporate})> isValidReferralCode(
      int code) async {
    final res =
        await _client.from('profile').select('role').eq('referral_code', code);
    if (res.isEmpty) {
      return (
        isValid: false,
        isCorporate: false,
      );
    }
    return (
      isValid: res.isNotEmpty,
      isCorporate: res.first['role'] == UserRole.Corporate.toString()
    );
  }

  @override
  String? get sessionId => _client.auth.currentSession?.user.id;

  @override
  Future<bool> signOut() async {
    await _client.auth.signOut(scope: SignOutScope.global);
    return true;
  }

  @override
  Future<bool> updatePassword({
    String? email,
    String? phone,
    required String newPassword,
  }) async {
    ///Check if the email or phone is not null
    assert(email != null || phone != null);
    try {
      await _client.auth.updateUser(
        UserAttributes(
          email: email,
          phone: phone,
          password: newPassword,
        ),
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> verifyOtp({
    String? email,
    String? phone,
    required String otp,
    required OtpType type,
  }) async {
    try {
      await _client.auth.verifyOTP(
        email: email,
        phone: phone,
        token: otp,
        type: type,
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> signIn({
    String? email,
    String? phone,
    required String password,
  }) async {
    try {
      final result = await _client.auth.signInWithPassword(
        email: email,
        phone: phone,
        password: password,
      );

      return result.session != null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> signUp({
    String? email,
    String? phone,
    required String password,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _client.auth.signUp(
        email: email,
        phone: phone,
        password: password,
        data: data,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> isValidRSAID({required String id, required String apiKey}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> isActive(String id) async {
    final res = await _client
        .from('profile')
        .select('is_active')
        .eq('user_id', id)
        .single();
    return res['is_active'];
  }

  @override
  Future<bool> resetPasswordWithEmail(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<bool> resetPasswordWithPhone(String phone) async {
    try {
      await _client.auth.signInWithOtp(phone: phone);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> resendOtp({
    String? email,
    String? phone,
    required OtpType type,
  }) async {
    try {
      await _client.auth.resend(
        email: email,
        phone: phone,
        type: type,
      );
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  @override
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  @override
  Future<bool> signInAnon() async {
    try {
      final result = await _client.auth.signInAnonymously();
      return result.session != null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> fetchSystemIssue() async {
    try {
      final res = await _client
          .schema('system_configs')
          .from('remote_config')
          .select('text_value')
          .eq('id', 'system_issue')
          .single();
      return res['text_value'];
    } catch (e) {
      return null;
    }
  }
}
