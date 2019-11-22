import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  final String _useDarkModeKey = 'useDarkMode';
  final String _openInAppKey = 'openInApp';
  final String _favoritesKey = 'favorites';
  final String _deviceIdKey = 'deviceID';
  final String _viewsKey = 'views';
  final String _searchHistoyKey = 'searchHistory';
  final String _emailSignInKey = 'email';
  final String _passwordSignInKey = 'password';
  final String _authenticationMethodKey = 'authenticationMethod';

  final SharedPreferences _sharedPreferences;

  const PreferencesService(this._sharedPreferences);

  set useDarkMode(bool useDarkMode) {
    _sharedPreferences.setBool(_useDarkModeKey, useDarkMode);
  }

  bool get useDarkMode => _sharedPreferences.getBool(_useDarkModeKey) ?? false;

  bool get openInApp => _sharedPreferences.getBool(_openInAppKey) ?? true;

  List<String> get favorites =>
    _sharedPreferences.getStringList(_favoritesKey) ?? List<String>();

  List<String> get views =>
    _sharedPreferences.getStringList(_viewsKey) ?? List<String>();

  List<String> get searchHistory => 
    _sharedPreferences.getStringList(_searchHistoyKey) ?? List<String>();

  String get deviceId =>
    _sharedPreferences.getString(_deviceIdKey) ?? '';

  String get email => 
    _sharedPreferences.getString(_emailSignInKey);

  String get password => 
    _sharedPreferences.getString(_passwordSignInKey);

  String get authenticationMethod => 
    _sharedPreferences.getString(_authenticationMethodKey);

  set openInApp(bool openInApp) {
    _sharedPreferences.setBool(_openInAppKey, openInApp);
  }

  set favorites(List<String> favourites) {
    _sharedPreferences.setStringList(_favoritesKey, favourites);
  }

  set views(List<String> views) {
    _sharedPreferences.setStringList(_viewsKey, views);
  }

  set searchHistory(List<String> searchTerms) {
    _sharedPreferences.setStringList(_searchHistoyKey, searchTerms);
  }

  set deviceId(String deviceId) {
    _sharedPreferences.setString(_deviceIdKey, deviceId);
  }

  set email(String email) {
    _sharedPreferences.setString(_emailSignInKey, email);
  }

  set password(String password) {
    _sharedPreferences.setString(_passwordSignInKey, password);
  }

  set authenticationMethod(String authenticationMethod) {
    _sharedPreferences.setString(_authenticationMethodKey, authenticationMethod);
  }
}