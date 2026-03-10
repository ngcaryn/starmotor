import 'package:starmotor/models/user_model.dart';
import 'package:starmotor/services/api_service.dart';
import 'package:starmotor/services/storage_service.dart';

class AuthService {
  final ApiService _api;
  final StorageService _storage;

  AuthService({ApiService? api, StorageService? storage})
      : _api = api ?? ApiService(),
        _storage = storage ?? StorageService();

  Future<UserModel?> getCurrentUser() async {
    final token = await _storage.getAuthToken();
    if (token == null) return null;
    final userData = await _storage.getUserData();
    if (userData == null) return null;
    _api.setAuthToken(token);
    return UserModel.fromJson(userData);
  }

  Future<UserModel> loginWithEmail(
      {required String email, required String password}) async {
    // Mock implementation — swap for real API call
    await Future.delayed(const Duration(milliseconds: 800));
    final mockUser = UserModel(
      id: 'user_001',
      nickname: '星驰用户',
      email: email,
      token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
      createdAt: DateTime.now(),
    );
    await _persistUser(mockUser);
    return mockUser;
  }

  Future<UserModel> loginWithPhone(
      {required String phone, required String otp}) async {
    // Mock implementation
    await Future.delayed(const Duration(milliseconds: 800));
    final mockUser = UserModel(
      id: 'user_001',
      nickname: '星驰用户',
      phone: phone,
      token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
      createdAt: DateTime.now(),
    );
    await _persistUser(mockUser);
    return mockUser;
  }

  Future<void> sendOtp(String phone) async {
    // Mock: in production call ApiConfig.sendOtp
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<UserModel> signup({
    required String nickname,
    required String phone,
    required String password,
  }) async {
    // Mock implementation
    await Future.delayed(const Duration(milliseconds: 1000));
    final mockUser = UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      nickname: nickname,
      phone: phone,
      token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
      createdAt: DateTime.now(),
    );
    await _persistUser(mockUser);
    return mockUser;
  }

  Future<void> logout() async {
    _api.setAuthToken(null);
    await _storage.clearAuth();
  }

  Future<void> _persistUser(UserModel user) async {
    if (user.token != null) {
      await _storage.saveAuthToken(user.token!);
      _api.setAuthToken(user.token);
    }
    await _storage.saveUserData(user.toJson());
  }
}
