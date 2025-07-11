import '../../local/shared_prefs_service.dart';

extension SharedPrefsValuesExtension on SharedPrefsValues {
  String get getKey {
    switch (this) {
      case SharedPrefsValues.accessToken:
        return 'access_token';
    }
  }
}