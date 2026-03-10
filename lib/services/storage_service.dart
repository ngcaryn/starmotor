import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService._();

  static final StorageService _instance = StorageService._();
  static StorageService get instance => _instance;

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userDataKey = 'user_data';
  static const String _onboardingKey = 'onboarding_completed';
  static const String _themeKey = 'app_theme';
  static const String _languageKey = 'app_language';

  SharedPreferences? _prefs;

  Future<SharedPreferences> get _preferences async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  // Access token
  Future<void> saveAccessToken(String token) async {
    final prefs = await _preferences;
    await prefs.setString(_accessTokenKey, token);
  }

  Future<String?> getAccessToken() async {
    final prefs = await _preferences;
    return prefs.getString(_accessTokenKey);
  }

  // Refresh token
  Future<void> saveRefreshToken(String token) async {
    final prefs = await _preferences;
    await prefs.setString(_refreshTokenKey, token);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await _preferences;
    return prefs.getString(_refreshTokenKey);
  }

  // User data
  Future<void> saveUserData(String userJson) async {
    final prefs = await _preferences;
    await prefs.setString(_userDataKey, userJson);
  }

  Future<String?> getUserData() async {
    final prefs = await _preferences;
    return prefs.getString(_userDataKey);
  }

  // Onboarding
  Future<void> setOnboardingCompleted() async {
    final prefs = await _preferences;
    await prefs.setBool(_onboardingKey, true);
  }

  Future<bool> isOnboardingCompleted() async {
    final prefs = await _preferences;
    return prefs.getBool(_onboardingKey) ?? false;
  }

  // Theme
  Future<void> saveTheme(String theme) async {
    final prefs = await _preferences;
    await prefs.setString(_themeKey, theme);
  }

  Future<String?> getTheme() async {
    final prefs = await _preferences;
    return prefs.getString(_themeKey);
  }

  // Language
  Future<void> saveLanguage(String language) async {
    final prefs = await _preferences;
    await prefs.setString(_languageKey, language);
  }

  Future<String?> getLanguage() async {
    final prefs = await _preferences;
    return prefs.getString(_languageKey);
  }

  // Generic storage
  Future<void> setString(String key, String value) async {
    final prefs = await _preferences;
    await prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await _preferences;
    return prefs.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    final prefs = await _preferences;
    await prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final prefs = await _preferences;
    return prefs.getBool(key);
  }

  Future<void> remove(String key) async {
    final prefs = await _preferences;
    await prefs.remove(key);
  }

  Future<void> clearAll() async {
    final prefs = await _preferences;
    await prefs.clear();
  }
}
