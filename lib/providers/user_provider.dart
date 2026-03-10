import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../models/order_model.dart';
import '../services/auth_service.dart';
import 'auth_provider.dart';

final currentUserProvider = Provider<UserModel?>((ref) {
  return ref.watch(authNotifierProvider).valueOrNull;
});

final userOrdersProvider =
    FutureProvider<List<OrderModel>>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];

  // Mock data - replace with actual API call
  await Future.delayed(const Duration(milliseconds: 800));
  return _getMockOrders(user.id);
});

List<OrderModel> _getMockOrders(String userId) {
  return [
    OrderModel(
      id: 'ord_001',
      userId: userId,
      type: OrderType.mall,
      status: OrderStatus.delivered,
      totalAmount: 880,
      isPaid: true,
      paymentMethod: 'WeChat Pay',
      items: [
        const OrderItemModel(
          id: 'item_001',
          itemId: 'prod_003',
          itemName: '全天候脚垫',
          unitPrice: 880,
          quantity: 1,
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      estimatedDelivery: DateTime.now().subtract(const Duration(days: 10)),
    ),
    OrderModel(
      id: 'ord_002',
      userId: userId,
      type: OrderType.car,
      status: OrderStatus.confirmed,
      totalAmount: 338000,
      isPaid: false,
      items: [
        const OrderItemModel(
          id: 'item_002',
          itemId: 'car_001',
          itemName: '星驰S7 进阶版',
          unitPrice: 338000,
          quantity: 1,
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];
}

final userProfileNotifierProvider =
    StateNotifierProvider<UserProfileNotifier, AsyncValue<UserModel?>>((ref) {
  final user = ref.watch(authNotifierProvider).valueOrNull;
  return UserProfileNotifier(initialUser: user);
});

class UserProfileNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  UserProfileNotifier({UserModel? initialUser})
      : super(AsyncValue.data(initialUser));

  Future<void> updateProfile({
    String? nickname,
    String? bio,
    String? avatarUrl,
  }) async {
    final user = state.valueOrNull;
    if (user == null) return;

    state = const AsyncValue.loading();
    try {
      // Mock update - replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));
      state = AsyncValue.data(
        user.copyWith(
          nickname: nickname,
          bio: bio,
          avatarUrl: avatarUrl,
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
