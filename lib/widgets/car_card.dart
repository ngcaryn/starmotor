import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../config/theme_config.dart';

class CarCard extends StatelessWidget {
  final CarModel car;
  final VoidCallback? onTap;

  const CarCard({super.key, required this.car, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car image
            Stack(
              children: [
                car.thumbnailUrl != null
                    ? Image.network(
                        car.thumbnailUrl!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 200,
                          color: AppColors.grey200,
                          child: const Center(
                            child: Icon(Icons.directions_car, size: 64),
                          ),
                        ),
                      )
                    : Container(
                        height: 200,
                        color: AppColors.grey200,
                        child: const Center(
                          child: Icon(Icons.directions_car, size: 64),
                        ),
                      ),
                // Fuel type badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getFuelTypeColor(car.fuelType),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _getFuelTypeLabel(car.fuelType),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            car.nameChinese,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            car.name,
                            style: const TextStyle(
                                color: AppColors.grey500, fontSize: 13),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '¥${(car.basePrice / 10000).toStringAsFixed(1)}万起',
                            style: const TextStyle(
                              color: AppColors.accent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          if (car.promotionalPrice != null)
                            Text(
                              '限时优惠',
                              style: TextStyle(
                                color: AppColors.success.withAlpha(180),
                                fontSize: 11,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Highlights
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: car.highlights
                        .take(3)
                        .map((h) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.grey100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                h,
                                style: const TextStyle(
                                    fontSize: 11, color: AppColors.grey700),
                              ),
                            ))
                        .toList(),
                  ),

                  const SizedBox(height: 12),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // TODO: Navigate to test drive booking
                          },
                          style: OutlinedButton.styleFrom(
                              minimumSize: const Size(0, 36)),
                          child: const Text('预约试驾', style: TextStyle(fontSize: 13)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onTap,
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(0, 36)),
                          child: const Text('查看详情', style: TextStyle(fontSize: 13)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getFuelTypeColor(String fuelType) {
    switch (fuelType) {
      case 'electric':
        return AppColors.success;
      case 'hybrid':
        return AppColors.info;
      default:
        return AppColors.grey500;
    }
  }

  String _getFuelTypeLabel(String fuelType) {
    switch (fuelType) {
      case 'electric':
        return '纯电动';
      case 'hybrid':
        return '插电混动';
      default:
        return '燃油';
    }
  }
}
