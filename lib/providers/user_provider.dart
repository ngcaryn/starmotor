import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starmotor/models/user_model.dart';
import 'package:starmotor/models/order_model.dart';
import 'package:starmotor/providers/auth_provider.dart';

class UserProfileNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  final Ref _ref;

  UserProfileNotifier(this._ref) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    final authState = _ref.read(authNotifierProvider);
    state = authState.whenData((user) => user);
  }

  Future<void> updateProfile({
    String? nickname,
    String? bio,
    String? avatar,
  }) async {
    final current = state.valueOrNull;
    if (current == null) return;
    // Mock update
    await Future.delayed(const Duration(milliseconds: 500));
    state = AsyncValue.data(current.copyWith(
      nickname: nickname,
      bio: bio,
      avatar: avatar,
    ));
  }
}

final userProfileNotifierProvider =
    StateNotifierProvider<UserProfileNotifier, AsyncValue<UserModel?>>(
        (ref) => UserProfileNotifier(ref));

// Orders
final userOrdersProvider =
    FutureProvider<List<OrderModel>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return [
    OrderModel(
      id: 'order_001',
      userId: 'user_001',
      items: [
        {'name': '星驰原厂脚垫套装', 'qty': 1, 'price': 899},
      ],
      totalAmount: 899,
      status: OrderStatus.delivered,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
    OrderModel(
      id: 'order_002',
      userId: 'user_001',
      items: [
        {'name': '车载香氛套装', 'qty': 2, 'price': 598},
      ],
      totalAmount: 598,
      status: OrderStatus.paid,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];
});
