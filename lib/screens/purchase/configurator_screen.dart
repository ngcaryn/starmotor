import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starmotor/models/car_model.dart';
import 'package:starmotor/providers/purchase_provider.dart';

class ConfiguratorScreen extends ConsumerWidget {
  final CarModel car;

  const ConfiguratorScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configState = ref.watch(carConfigProvider(car));
    final notifier = ref.read(carConfigProvider(car).notifier);

    return Scaffold(
      appBar: AppBar(title: Text('配置 ${car.name}')),
      body: Stepper(
        currentStep: configState.step,
        onStepContinue: configState.step < 2 ? notifier.nextStep : null,
        onStepCancel:
            configState.step > 0 ? notifier.prevStep : null,
        steps: [
          Step(
            title: const Text('选择版本'),
            isActive: configState.step >= 0,
            state: configState.step > 0
                ? StepState.complete
                : StepState.indexed,
            content: Column(
              children: car.variants.map((variant) {
                final selected =
                    configState.selectedVariant?.id == variant.id;
                return Card(
                  color: selected
                      ? Theme.of(context).colorScheme.primaryContainer
                      : null,
                  child: RadioListTile<CarVariant>(
                    value: variant,
                    groupValue: configState.selectedVariant,
                    onChanged: (v) {
                      if (v != null) notifier.selectVariant(v);
                    },
                    title: Text(variant.name),
                    subtitle: Text('续航 ${variant.range}'),
                    secondary: Text(
                      '¥${(variant.price / 10000).toStringAsFixed(1)}万',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Step(
            title: const Text('选择颜色'),
            isActive: configState.step >= 1,
            state: configState.step > 1
                ? StepState.complete
                : StepState.indexed,
            content: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: car.colors.map((color) {
                final selected =
                    configState.selectedColor?.name == color.name;
                return GestureDetector(
                  onTap: () => notifier.selectColor(color),
                  child: Column(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Color(color.colorValue),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                selected ? Colors.blue : Colors.grey,
                            width: selected ? 3 : 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(color.name,
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Step(
            title: const Text('确认订单'),
            isActive: configState.step >= 2,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SummaryRow(
                    label: '车型',
                    value: car.name),
                _SummaryRow(
                    label: '版本',
                    value: configState.selectedVariant?.name ?? '-'),
                _SummaryRow(
                    label: '颜色',
                    value: configState.selectedColor?.name ?? '-'),
                const Divider(),
                _SummaryRow(
                    label: '总价',
                    value:
                        '¥${(configState.totalPrice / 10000).toStringAsFixed(1)}万',
                    isTotal: true),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('提交订单'),
                        content: const Text('确认提交订单吗？销售顾问将在24小时内联系您。'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('取消')),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('订单已提交，请等待顾问联系')),
                              );
                            },
                            child: const Text('确认'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('提交意向订单'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _SummaryRow(
      {required this.label, required this.value, this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: isTotal
                  ? const TextStyle(fontWeight: FontWeight.bold)
                  : null),
          Text(value,
              style: isTotal
                  ? const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 18)
                  : null),
        ],
      ),
    );
  }
}
