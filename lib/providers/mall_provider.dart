import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starmotor/models/product_model.dart';

List<ProductModel> _mockProducts() => [
      ProductModel(
        id: 'prod_001',
        name: '星驰原厂脚垫套装',
        description: '专车专用，全包围防水防滑，完美贴合车型',
        price: 899,
        originalPrice: 1299,
        category: '车内装饰',
        stock: 50,
        rating: 4.8,
        reviewCount: 234,
        isFeatured: true,
        coverImage: 'https://picsum.photos/seed/mat/300/300',
      ),
      ProductModel(
        id: 'prod_002',
        name: '车载香氛套装',
        description: '高端香水品牌联名，持久留香',
        price: 299,
        originalPrice: 399,
        category: '车内装饰',
        stock: 100,
        rating: 4.6,
        reviewCount: 189,
        coverImage: 'https://picsum.photos/seed/fragrance/300/300',
      ),
      ProductModel(
        id: 'prod_003',
        name: '隔热防晒遮阳帘',
        description: '磁吸安装，隔热率98%，适配全系车型',
        price: 599,
        category: '车窗贴膜',
        stock: 30,
        rating: 4.7,
        reviewCount: 156,
        coverImage: 'https://picsum.photos/seed/sunshade/300/300',
      ),
      ProductModel(
        id: 'prod_004',
        name: '星驰定制行李箱',
        description: '联名款20寸登机箱，星驰车主专属',
        price: 1299,
        originalPrice: 1599,
        category: '品牌周边',
        stock: 20,
        rating: 4.9,
        reviewCount: 78,
        isFeatured: true,
        coverImage: 'https://picsum.photos/seed/luggage/300/300',
      ),
    ];

// Products
class MallProductsNotifier
    extends StateNotifier<AsyncValue<List<ProductModel>>> {
  MallProductsNotifier() : super(const AsyncValue.loading()) {
    _load();
  }

  String _selectedCategory = '全部';

  Future<void> _load() async {
    state = const AsyncValue.loading();
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      state = AsyncValue.data(_mockProducts());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void filterByCategory(String category) {
    _selectedCategory = category;
    if (category == '全部') {
      state = AsyncValue.data(_mockProducts());
    } else {
      state = AsyncValue.data(
          _mockProducts().where((p) => p.category == category).toList());
    }
  }
}

final mallProductsProvider = StateNotifierProvider<MallProductsNotifier,
    AsyncValue<List<ProductModel>>>(
  (ref) => MallProductsNotifier(),
);

// Cart
class CartNotifier extends StateNotifier<List<CartItemModel>> {
  CartNotifier() : super([]);

  void addItem(ProductModel product, {int quantity = 1}) {
    final existingIndex =
        state.indexWhere((item) => item.productId == product.id);
    if (existingIndex >= 0) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == existingIndex)
            state[i].copyWith(quantity: state[i].quantity + quantity)
          else
            state[i],
      ];
    } else {
      state = [
        ...state,
        CartItemModel(
          id: 'cart_${DateTime.now().millisecondsSinceEpoch}',
          productId: product.id,
          productName: product.name,
          productImage: product.coverImage,
          price: product.price,
          quantity: quantity,
        ),
      ];
    }
  }

  void removeItem(String cartItemId) {
    state = state.where((item) => item.id != cartItemId).toList();
  }

  void updateQuantity(String cartItemId, int quantity) {
    if (quantity <= 0) {
      removeItem(cartItemId);
      return;
    }
    state = [
      for (final item in state)
        if (item.id == cartItemId) item.copyWith(quantity: quantity) else item,
    ];
  }

  void clear() => state = [];

  double get total =>
      state.fold(0, (sum, item) => sum + item.subtotal);
  int get itemCount => state.fold(0, (sum, item) => sum + item.quantity);
}

final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartItemModel>>(
        (ref) => CartNotifier());

final cartItemCountProvider = Provider<int>((ref) {
  return ref.watch(cartProvider).fold(0, (sum, item) => sum + item.quantity);
});
