import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starmotor/models/user_model.dart';
import 'package:starmotor/services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

class AuthNotifier extends AsyncNotifier<UserModel?> {
  @override
  Future<UserModel?> build() async {
    return ref.read(authServiceProvider).getCurrentUser();
  }

  Future<void> loginWithEmail(
      {required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref
          .read(authServiceProvider)
          .loginWithEmail(email: email, password: password),
    );
  }

  Future<void> loginWithPhone(
      {required String phone, required String otp}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref
          .read(authServiceProvider)
          .loginWithPhone(phone: phone, otp: otp),
    );
  }

  Future<void> signup({
    required String nickname,
    required String phone,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(authServiceProvider).signup(
            nickname: nickname,
            phone: phone,
            password: password,
          ),
    );
  }

  Future<void> logout() async {
    await ref.read(authServiceProvider).logout();
    state = const AsyncValue.data(null);
  }
}

final authNotifierProvider =
    AsyncNotifierProvider<AuthNotifier, UserModel?>(AuthNotifier.new);
