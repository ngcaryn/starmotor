import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starmotor/providers/purchase_provider.dart';
import 'package:starmotor/screens/purchase/car_detail_screen.dart';
import 'package:starmotor/widgets/car_card.dart';

class CarListScreen extends ConsumerWidget {
  const CarListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carsState = ref.watch(carListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('购车')),
      body: carsState.when(
        data: (cars) => RefreshIndicator(
          onRefresh: () => ref.read(carListProvider.notifier).refresh(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];
              return CarCard(
                car: car,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CarDetailScreen(car: car),
                  ),
                ),
              );
            },
          ),
        ),
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('加载失败：$e')),
      ),
    );
  }
}
