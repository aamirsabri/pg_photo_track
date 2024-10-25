import 'package:shared_preferences/shared_preferences.dart';

const String PREF_KEY_EMP_ID = "PREF_KEY_EMP_ID";

class AppPreference {
  SharedPreferences _sharedPreferences;
  static String USER_ID = "USERNAME";
  static String PASSWORD = "PASSWORD";
  static String IMEI = "IMEI";

  // AppP(){
  //   this._sharedPreferences = SharedPreferences.getInstance();
  // }
  AppPreference(this._sharedPreferences);
  Future<String?> getUserId() async {
    String? userId = _sharedPreferences.getString(USER_ID);
    if (userId == null || userId.isEmpty) {
      return null;
    } else {
      return userId;
    }
  }

  Future setUserId(String userId) async {
    await _sharedPreferences.setString(USER_ID, userId);
  }

  Future getValue(String key) async {
    String? value = await _sharedPreferences.getString(key);
    if (value == null || value.isEmpty) {
      return '';
    } else {
      return value;
    }
  }

  Future setPref(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }
}
