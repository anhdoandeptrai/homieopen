import '../utils/extensions/shared_prefs_values_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SharedPrefsValues { accessToken }

class SharedPrefsService {
  final SharedPreferences _prefs;

  SharedPrefsService({required SharedPreferences prefs}) : _prefs = prefs;

  Future<void> saveString(SharedPrefsValues key, String value) async {
    await _prefs.setString(key.getKey, value);
  }

  String? getString(SharedPrefsValues key) {
    return _prefs.getString(key.getKey);
  }

  Future<void> clearLocalData() async {
    await _prefs.clear();
  }
}