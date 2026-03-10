import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme_config.dart';
import '../../models/car_model.dart';
import '../../providers/purchase_provider.dart';

class ConfiguratorScreen extends ConsumerWidget {
  final CarModel car;

  const ConfiguratorScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(carConfigProvider);
    final notifier = ref.read(carConfigProvider.notifier);

    final selectedVariant = config.variantId != null
        ? car.variants.firstWhere(
            (v) => v.id == config.variantId,
            orElse: () => car.variants.first,
          )
        : car.variants.isNotEmpty
            ? car.variants.first
            : null;

    final selectedColor = config.colorId != null
        ? car.availableColors.firstWhere(
            (c) => c.id == config.colorId,
            orElse: () => car.availableColors.first,
          )
        : car.availableColors.isNotEmpty
            ? car.availableColors.first
            : null;

    double totalPrice = selectedVariant?.price ?? car.basePrice;
    if (selectedColor?.additionalPrice != null) {
      totalPrice += selectedColor!.additionalPrice!;
    }

    return Scaffold(
      appBar: AppBar(title: Text('配置 ${car.nameChinese}')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car image
            if (car.imageUrls.isNotEmpty)
              Image.network(
                car.imageUrls.first,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 200,
                  color: AppColors.grey200,
                  child: const Icon(Icons.directions_car, size: 80),
                ),
              ),

            // Version selector
            if (car.variants.isNotEmpty) ...[
              _SectionHeader(title: '选择版本'),
              ...car.variants.map(
                (variant) => RadioListTile<String>(
                  title: Text(variant.name),
                  subtitle: Text('¥${(variant.price / 10000).toStringAsFixed(1)}万'),
                  value: variant.id,
                  groupValue: config.variantId ?? car.variants.first.id,
                  onChanged: (val) {
                    if (val != null) notifier.selectVariant(val);
                  },
                  activeColor: AppColors.primary,
                ),
              ),
            ],

            // Color selector
            if (car.availableColors.isNotEmpty) ...[
              _SectionHeader(title: '选择颜色'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Wrap(
                  spacing: 12,
                  children: car.availableColors.map((color) {
                    final isSelected =
                        (config.colorId ?? car.availableColors.first.id) ==
                            color.id;
                    return GestureDetector(
                      onTap: () => notifier.selectColor(color.id),
                      child: Column(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Color(color.colorHex),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.transparent,
                                width: 3,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            color.nameChinese,
                            style: const TextStyle(fontSize: 12),
                          ),
                          if (color.additionalPrice != null)
                            Text(
                              '+¥${color.additionalPrice!.toInt()}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.accent,
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],

            const SizedBox(height: 80),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('总价', style: TextStyle(color: AppColors.grey500)),
                  Text(
                    '¥${(totalPrice / 10000).toStringAsFixed(1)}万',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _showOrderDialog(context, car, totalPrice);
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size(140, 48)),
              child: const Text('立即下订'),
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderDialog(BuildContext context, CarModel car, double price) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('确认订单'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('车型: ${car.nameChinese}'),
            const SizedBox(height: 8),
            Text('总价: ¥${(price / 10000).toStringAsFixed(1)}万'),
            const SizedBox(height: 16),
            const Text(
              '下订后，我们的顾问将在24小时内联系您。',
              style: TextStyle(color: AppColors.grey500, fontSize: 13),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('订单提交成功！顾问将尽快联系您。')),
              );
            },
            child: const Text('确认下订'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.grey900,
        ),
      ),
    );
  }
}
