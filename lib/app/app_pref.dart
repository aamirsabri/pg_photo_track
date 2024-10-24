import 'package:shared_preferences/shared_preferences.dart';

const String PREF_KEY_EMP_ID = "PREF_KEY_EMP_ID";

class AppPreference {
  SharedPreferences _sharedPreferences;
  static String USER_ID = "USERNAME";
  static String PASSWORD = "PASSWORD";

  // AppP(){
  //   this._sharedPreferences = SharedPreferences.getInstance();
  // }
  AppPreference(this._sharedPreferences);
  Future<String?> getEmpId() async {
    String? empId = _sharedPreferences.getString(PREF_KEY_EMP_ID);
    if (empId == null || empId.isEmpty) {
      return null;
    } else {
      return empId;
    }
  }

  Future setEmpId(String empId) async {
    await _sharedPreferences.setString(PREF_KEY_EMP_ID, empId);
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
