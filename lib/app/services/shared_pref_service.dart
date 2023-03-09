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

  static String? getUserDetail() {
    _ensureInitialized();
    return _pref?.getString('userDetail');
  }

  static Future storeUserDetail(String userDetail) async {
    await _pref?.setString('userDetail', userDetail);
  }

  static List<String>? getUserId() {
    _ensureInitialized();
    return _pref?.getStringList('user_id');
  }

  static Future storeUserId(List<String> userId) async {
    await _pref?.setStringList('user_id', userId);
  }

  static bool? getIsAgree() {
    _ensureInitialized();
    return _pref?.getBool('isAgree');
  }

  static Future storeIsAgree(bool isAgree) async {
    await _pref?.setBool('isAgree', isAgree);
  }

  static bool? getIsPrivacy() {
    _ensureInitialized();
    return _pref?.getBool('isPrivacy');
  }

  static Future storeIsPrivacy(bool isPrivacy) async {
    await _pref?.setBool('isPrivacy', isPrivacy);
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
