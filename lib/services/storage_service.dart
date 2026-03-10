import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _tokenKey = 'auth_token';
  static const String _userDataKey = 'user_data';
  static const String _themeKey = 'theme_mode';

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  // Auth token
  Future<String?> getAuthToken() async {
    final prefs = await _prefs;
    return prefs.getString(_tokenKey);
  }

  Future<void> saveAuthToken(String token) async {
    final prefs = await _prefs;
    await prefs.setString(_tokenKey, token);
  }

  // User data
  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_userDataKey);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<void> saveUserData(Map<String, dynamic> data) async {
    final prefs = await _prefs;
    await prefs.setString(_userDataKey, jsonEncode(data));
  }

  // Theme
  Future<String?> getThemeMode() async {
    final prefs = await _prefs;
    return prefs.getString(_themeKey);
  }

  Future<void> saveThemeMode(String mode) async {
    final prefs = await _prefs;
    await prefs.setString(_themeKey, mode);
  }

  // Generic key-value
  Future<String?> getString(String key) async {
    final prefs = await _prefs;
    return prefs.getString(key);
  }

  Future<void> setString(String key, String value) async {
    final prefs = await _prefs;
    await prefs.setString(key, value);
  }

  Future<bool?> getBool(String key) async {
    final prefs = await _prefs;
    return prefs.getBool(key);
  }

  Future<void> setBool(String key, bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(key, value);
  }

  Future<void> remove(String key) async {
    final prefs = await _prefs;
    await prefs.remove(key);
  }

  Future<void> clearAuth() async {
    final prefs = await _prefs;
    await prefs.remove(_tokenKey);
    await prefs.remove(_userDataKey);
  }

  Future<void> clearAll() async {
    final prefs = await _prefs;
    await prefs.clear();
  }
}
