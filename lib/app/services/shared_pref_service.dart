import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static SharedPreferences? _pref;

  static Future init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static String? getSessionToken() {
    _ensureInitialized();
    return _pref?.getString('sessionToken');
  }

  static Future storeSessionToken(String token) async {
    await _pref?.setString('sessionToken', token);
  }

  static Future removeSessionToken() async {
    await _pref?.remove('sessionToken');
  }

  static _ensureInitialized() {
    if (_pref == null) {
      throw StateError('Shared preference is not initialized');
    }
  }
}
