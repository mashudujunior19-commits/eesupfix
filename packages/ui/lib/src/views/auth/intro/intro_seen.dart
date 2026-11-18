import 'package:shared_preferences/shared_preferences.dart';

/// Decides whether the intro pages are shown. They are for new users: they
/// show every time the app opens signed out, until someone has signed in on
/// this device once.
abstract final class IntroSeen {
  static const _key = 'towris_signed_in_on_device_v1';

  /// True once someone has signed in on this device.
  static Future<bool> get() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_key) ?? false;
    } catch (_) {
      // If storage can't be read, skip the intro rather than block sign-in.
      return true;
    }
  }

  /// Called whenever a user is signed in.
  static Future<void> markSeen() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool(_key) == true) return;
      await prefs.setBool(_key, true);
    } catch (_) {
      // Not being able to save only means the intro shows again next time.
    }
  }
}
