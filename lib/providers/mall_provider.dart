import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';

final mallProductsProvider =
    StateNotifierProvider<MallProductsNotifier, AsyncValue<List<ProductModel>>>((ref) {
  return MallProductsNotifier();
});

class MallProductsNotifier extends StateNotifier<AsyncValue<List<ProductModel>>> {
  MallProductsNotifier() : super(const AsyncValue.loading()) {
    loadProducts();
  }

  String? _selectedCategoryId;

  Future<void> loadProducts({String? categoryId}) async {
    _selectedCategoryId = categoryId;
    state = const AsyncValue.loading();
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      final products = _getMockProducts();
      final filtered = categoryId != null
          ? products.where((p) => p.categoryId == categoryId).toList()
          : products;
      state = AsyncValue.data(filtered);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  List<ProductModel> _getMockProducts() {
    return [
      ProductModel(
        id: 'prod_001',
        name: 'Carbon Fiber Spoiler',
        nameChinese: '碳纤维尾翼',
        description: '原厂认证碳纤维尾翼，提升空气动力学性能',
        categoryId: 'cat_exterior',
        categoryName: '外观改装',
        price: 3800,
        imageUrls: ['https://picsum.photos/seed/spoiler/400/400'],
        thumbnailUrl: 'https://picsum.photos/seed/spoiler/200/200',
        stockCount: 15,
        rating: 4.8,
        reviewCount: 62,
        isFeatured: true,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      ProductModel(
        id: 'prod_002',
        name: 'Starmotor Branded Mug',
        nameChinese: '星驰品牌保温杯',
        description: '高品质不锈钢保温杯，星驰品牌周边',
        categoryId: 'cat_merchandise',
        categoryName: '品牌周边',
        price: 168,
        originalPrice: 198,
        imageUrls: ['https://picsum.photos/seed/mug/400/400'],
        thumbnailUrl: 'https://picsum.photos/seed/mug/200/200',
        stockCount: 200,
        rating: 4.6,
        reviewCount: 148,
        isOnSale: true,
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
      ProductModel(
        id: 'prod_003',
        name: 'All-Weather Floor Mats',
        nameChinese: '全天候脚垫',
        description: '原厂定制全包围脚垫，防水防滑',
        categoryId: 'cat_interior',
        categoryName: '内饰配件',
        price: 880,
        imageUrls: ['https://picsum.photos/seed/mats/400/400'],
        thumbnailUrl: 'https://picsum.photos/seed/mats/200/200',
        stockCount: 50,
        rating: 4.9,
        reviewCount: 234,
        isFeatured: true,
        createdAt: DateTime.now().subtract(const Duration(days: 60)),
      ),
    ];
  }
}

final mallCategoriesProvider =
    StateNotifierProvider<MallCategoriesNotifier, AsyncValue<List<ProductCategory>>>((ref) {
  return MallCategoriesNotifier();
});

class MallCategoriesNotifier
    extends StateNotifier<AsyncValue<List<ProductCategory>>> {
  MallCategoriesNotifier() : super(const AsyncValue.loading()) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    state = const AsyncValue.loading();
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      state = AsyncValue.data(_getMockCategories());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  List<ProductCategory> _getMockCategories() {
    return [
      const ProductCategory(
        id: 'cat_exterior',
        name: 'Exterior',
        nameChinese: '外观改装',
        productCount: 24,
      ),
      const ProductCategory(
        id: 'cat_interior',
        name: 'Interior',
        nameChinese: '内饰配件',
        productCount: 38,
      ),
      const ProductCategory(
        id: 'cat_electronics',
        name: 'Electronics',
        nameChinese: '电子设备',
        productCount: 16,
      ),
      const ProductCategory(
        id: 'cat_merchandise',
        name: 'Merchandise',
        nameChinese: '品牌周边',
        productCount: 52,
      ),
      const ProductCategory(
        id: 'cat_care',
        name: 'Car Care',
        nameChinese: '养护用品',
        productCount: 31,
      ),
    ];
  }
}

final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartItemModel>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItemModel>> {
  CartNotifier() : super([]);

  void addItem(ProductModel product, {int quantity = 1}) {
    final existingIndex = state.indexWhere((item) => item.productId == product.id);
    if (existingIndex != -1) {
      final updatedCart = [...state];
      updatedCart[existingIndex] = updatedCart[existingIndex].copyWith(
        quantity: updatedCart[existingIndex].quantity + quantity,
      );
      state = updatedCart;
    } else {
      state = [
        ...state,
        CartItemModel(
          id: 'cart_${DateTime.now().millisecondsSinceEpoch}',
          productId: product.id,
          product: product,
          quantity: quantity,
          addedAt: DateTime.now(),
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
    state = state
        .map((item) =>
            item.id == cartItemId ? item.copyWith(quantity: quantity) : item)
        .toList();
  }

  void clear() {
    state = [];
  }

  double get totalAmount =>
      state.fold(0, (sum, item) => sum + item.totalPrice);

  int get totalItemCount =>
      state.fold(0, (sum, item) => sum + item.quantity);
}
