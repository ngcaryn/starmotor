import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starmotor/providers/mall_provider.dart';
import 'package:starmotor/widgets/product_card.dart';

class MallHomeScreen extends ConsumerWidget {
  const MallHomeScreen({super.key});

  static const _categories = ['全部', '车内装饰', '车窗贴膜', '品牌周边', '充电配件'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(mallProductsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('商城'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => _showCart(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          // Category strip
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cat),
                    selected: false,
                    onSelected: (_) => ref
                        .read(mallProductsProvider.notifier)
                        .filterByCategory(cat),
                  ),
                );
              },
            ),
          ),
          // Products
          Expanded(
            child: productsState.when(
              data: (products) => GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    product: product,
                    onAddToCart: () =>
                        ref.read(cartProvider.notifier).addItem(product),
                  );
                },
              ),
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('加载失败：$e')),
            ),
          ),
        ],
      ),
    );
  }

  void _showCart(BuildContext context, WidgetRef ref) {
    final cartItems = ref.read(cartProvider);
    showModalBottomSheet(
      context: context,
      builder: (_) => _CartSheet(items: cartItems, ref: ref),
    );
  }
}

class _CartSheet extends StatelessWidget {
  final List cartItems;
  final WidgetRef ref;

  const _CartSheet({required this.cartItems, required this.ref});

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(cartProvider);
    final total = ref.read(cartProvider.notifier).total;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('购物车',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () =>
                    ref.read(cartProvider.notifier).clear(),
                child: const Text('清空'),
              ),
            ],
          ),
        ),
        if (items.isEmpty)
          const Expanded(child: Center(child: Text('购物车为空')))
        else ...[
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item.productName),
                  subtitle: Text('¥${item.price}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => ref
                            .read(cartProvider.notifier)
                            .updateQuantity(item.id, item.quantity - 1),
                      ),
                      Text('${item.quantity}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => ref
                            .read(cartProvider.notifier)
                            .updateQuantity(item.id, item.quantity + 1),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('合计 ¥${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('结算功能即将开放')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12)),
                  child: const Text('去结算'),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
