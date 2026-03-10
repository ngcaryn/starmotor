import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme_config.dart';
import '../../models/product_model.dart';
import '../../providers/mall_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.nameChinese),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product images
            if (product.imageUrls.isNotEmpty)
              SizedBox(
                height: 300,
                child: PageView.builder(
                  itemCount: product.imageUrls.length,
                  itemBuilder: (_, i) => Image.network(
                    product.imageUrls[i],
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.grey200,
                      child: const Icon(Icons.image, size: 64),
                    ),
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '¥${product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accent,
                        ),
                      ),
                      if (product.originalPrice != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          '¥${product.originalPrice!.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.grey500,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                      const Spacer(),
                      if (!product.inStock)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.grey200,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('缺货',
                              style: TextStyle(color: AppColors.grey500)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Name
                  Text(
                    product.nameChinese,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),

                  // Rating
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (i) => Icon(
                          Icons.star,
                          size: 16,
                          color: i < product.rating
                              ? Colors.amber
                              : AppColors.grey300,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${product.rating} (${product.reviewCount}评价)',
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.grey500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  const Divider(),

                  // Description
                  const Text(
                    '商品详情',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(
                        fontSize: 14, height: 1.6, color: AppColors.grey700),
                  ),
                  const SizedBox(height: 24),

                  // Tags
                  if (product.tags.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      children: product.tags
                          .map((tag) => Chip(
                                label: Text(tag),
                                backgroundColor: AppColors.grey100,
                              ))
                          .toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.grey200)),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: product.inStock
                    ? () {
                        ref.read(cartProvider.notifier).addItem(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('已加入购物车')),
                        );
                      }
                    : null,
                child: const Text('加入购物车'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: product.inStock
                    ? () {
                        // TODO: Direct checkout
                      }
                    : null,
                child: const Text('立即购买'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
