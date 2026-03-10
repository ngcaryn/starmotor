import 'package:flutter/material.dart';
import 'package:starmotor/models/car_model.dart';

class CarCard extends StatelessWidget {
  final CarModel car;
  final VoidCallback? onTap;

  const CarCard({super.key, required this.car, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover image
            if (car.coverImage != null)
              Image.network(
                car.coverImage!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              )
            else
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey.shade200,
                child: const Icon(Icons.directions_car,
                    size: 64, color: Colors.grey),
              ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and fuel-type badge
                  Row(
                    children: [
                      Text(
                        car.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: _fuelColor(car.fuelType),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          car.fuelType,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                  if (car.tagline != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      car.tagline!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                  const SizedBox(height: 8),
                  // Highlights
                  if (car.highlights.isNotEmpty)
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: car.highlights
                          .take(3)
                          .map((h) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue.shade200),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(h,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.blue)),
                              ))
                          .toList(),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    '参考售价 ¥${(car.startingPrice / 10000).toStringAsFixed(1)}万起',
                    style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _fuelColor(String type) {
    if (type.contains('纯电')) return Colors.green;
    if (type.contains('增程')) return Colors.blue;
    if (type.contains('混动')) return Colors.teal;
    return Colors.orange;
  }
}
