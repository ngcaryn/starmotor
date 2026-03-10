import 'dart:convert';
import '../models/user_model.dart';
import 'api_service.dart';
import 'storage_service.dart';

class AuthResult {
  final UserModel user;
  final String accessToken;
  final String refreshToken;

  const AuthResult({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });
}

class AuthService {
  AuthService._();

  static final AuthService _instance = AuthService._();
  static AuthService get instance => _instance;

  final ApiService _api = ApiService.instance;
  final StorageService _storage = StorageService.instance;

  Future<UserModel?> getCurrentUser() async {
    final token = await _storage.getAccessToken();
    if (token == null) return null;

    try {
      final userJson = await _storage.getUserData();
      if (userJson != null) {
        return UserModel.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
      }
      // Fetch from API if not cached
      final response = await _api.get('/user/profile');
      final user = UserModel.fromJson(response as Map<String, dynamic>);
      await _storage.saveUserData(jsonEncode(user.toJson()));
      return user;
    } catch (_) {
      return null;
    }
  }

  Future<AuthResult> loginWithPhone({
    required String phone,
    required String otp,
  }) async {
    // Mock implementation - replace with actual API call
    await Future.delayed(const Duration(seconds: 1));

    final mockUser = UserModel(
      id: 'user_001',
      username: 'user_${phone.substring(phone.length - 4)}',
      nickname: '星驰用户',
      phone: phone,
      createdAt: DateTime.now(),
    );

    const mockToken = 'mock_access_token_12345';
    const mockRefresh = 'mock_refresh_token_67890';

    await _storage.saveAccessToken(mockToken);
    await _storage.saveRefreshToken(mockRefresh);
    await _storage.saveUserData(jsonEncode(mockUser.toJson()));

    return AuthResult(
      user: mockUser,
      accessToken: mockToken,
      refreshToken: mockRefresh,
    );
  }

  Future<AuthResult> loginWithEmail({
    required String email,
    required String password,
  }) async {
    // Mock implementation - replace with actual API call
    await Future.delayed(const Duration(seconds: 1));

    final mockUser = UserModel(
      id: 'user_002',
      username: email.split('@').first,
      nickname: '星驰用户',
      email: email,
      createdAt: DateTime.now(),
    );

    const mockToken = 'mock_access_token_abcde';
    const mockRefresh = 'mock_refresh_token_fghij';

    await _storage.saveAccessToken(mockToken);
    await _storage.saveRefreshToken(mockRefresh);
    await _storage.saveUserData(jsonEncode(mockUser.toJson()));

    return AuthResult(
      user: mockUser,
      accessToken: mockToken,
      refreshToken: mockRefresh,
    );
  }

  Future<AuthResult> signUp({
    required String nickname,
    required String phone,
    required String otp,
    String? email,
  }) async {
    // Mock implementation - replace with actual API call
    await Future.delayed(const Duration(seconds: 1));

    final mockUser = UserModel(
      id: 'user_new_${DateTime.now().millisecondsSinceEpoch}',
      username: 'user_${phone.substring(phone.length - 4)}',
      nickname: nickname,
      phone: phone,
      email: email,
      createdAt: DateTime.now(),
    );

    const mockToken = 'mock_access_token_new';
    const mockRefresh = 'mock_refresh_token_new';

    await _storage.saveAccessToken(mockToken);
    await _storage.saveRefreshToken(mockRefresh);
    await _storage.saveUserData(jsonEncode(mockUser.toJson()));

    return AuthResult(
      user: mockUser,
      accessToken: mockToken,
      refreshToken: mockRefresh,
    );
  }

  Future<void> sendOtp(String phone) async {
    // Mock implementation - replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    // In production: await _api.post(ApiConfig.sendOtp, body: {'phone': phone});
  }

  Future<void> logout() async {
    try {
      await _api.post('/auth/logout');
    } catch (_) {
      // Continue with local logout even if API fails
    } finally {
      await _storage.clearAll();
    }
  }

  Future<bool> refreshAccessToken() async {
    final refreshToken = await _storage.getRefreshToken();
    if (refreshToken == null) return false;

    try {
      final response = await _api.post(
        '/auth/refresh',
        body: {'refresh_token': refreshToken},
      );
      final newToken = response['access_token'] as String;
      await _storage.saveAccessToken(newToken);
      return true;
    } catch (_) {
      await _storage.clearAll();
      return false;
    }
  }
}
