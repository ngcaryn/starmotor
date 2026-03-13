import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starmotor/models/car_model.dart';

List<CarModel> _mockCars() => [
      CarModel(
        id: 'car_001',
        name: '星驰 L9',
        series: 'L系列',
        startingPrice: 459800,
        fuelType: '增程电动',
        tagline: '六座旗舰，家的移动空间',
        highlights: ['续航超过1000公里', '六座豪华布局', 'NOA智能辅助驾驶'],
        coverImage: 'https://picsum.photos/seed/l9/600/400',
        images: [
          'https://picsum.photos/seed/l9a/600/400',
          'https://picsum.photos/seed/l9b/600/400',
        ],
        variants: [
          CarVariant(
            id: 'v001',
            name: 'Air版',
            price: 459800,
            range: '1000km+',
            acceleration: '5.9s',
          ),
          CarVariant(
            id: 'v002',
            name: 'Pro版',
            price: 499800,
            range: '1100km+',
            acceleration: '5.9s',
          ),
          CarVariant(
            id: 'v003',
            name: 'Max版',
            price: 539800,
            range: '1200km+',
            acceleration: '5.9s',
          ),
        ],
        colors: [
          CarColor(name: '星云白', colorValue: 0xFFF5F5F0),
          CarColor(name: '星际黑', colorValue: 0xFF1C1C1C),
          CarColor(name: '星辰蓝', colorValue: 0xFF2E4A7A),
        ],
        specs: CarSpecs(
          length: '5218mm',
          width: '1998mm',
          height: '1800mm',
          wheelbase: '3105mm',
          seats: '6',
          driveType: '四驱',
          batteryCapacity: '44.5kWh',
        ),
      ),
      CarModel(
        id: 'car_002',
        name: '星驰 L8',
        series: 'L系列',
        startingPrice: 359800,
        fuelType: '增程电动',
        tagline: '五/六座全能旗舰',
        highlights: ['家庭首选', '超大储物空间', '智能座舱'],
        coverImage: 'https://picsum.photos/seed/l8/600/400',
        images: ['https://picsum.photos/seed/l8a/600/400'],
        variants: [
          CarVariant(
            id: 'v004',
            name: 'Air版',
            price: 359800,
            range: '1000km+',
            acceleration: '5.3s',
          ),
          CarVariant(
            id: 'v005',
            name: 'Pro版',
            price: 399800,
            range: '1100km+',
            acceleration: '5.3s',
          ),
        ],
        colors: [
          CarColor(name: '皓月白', colorValue: 0xFFF8F8F5),
          CarColor(name: '墨影黑', colorValue: 0xFF1A1A1A),
        ],
      ),
    ];

class CarListNotifier extends StateNotifier<AsyncValue<List<CarModel>>> {
  CarListNotifier() : super(const AsyncValue.loading()) {
    _load();
  }

  Future<void> _load() async {
    state = const AsyncValue.loading();
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      state = AsyncValue.data(_mockCars());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() => _load();
}

final carListProvider =
    StateNotifierProvider<CarListNotifier, AsyncValue<List<CarModel>>>(
        (ref) => CarListNotifier());

// Car configurator state
class CarConfigState {
  final CarModel car;
  final CarVariant? selectedVariant;
  final CarColor? selectedColor;
  final int step;

  const CarConfigState({
    required this.car,
    this.selectedVariant,
    this.selectedColor,
    this.step = 0,
  });

  CarConfigState copyWith({
    CarVariant? selectedVariant,
    CarColor? selectedColor,
    int? step,
  }) =>
      CarConfigState(
        car: car,
        selectedVariant: selectedVariant ?? this.selectedVariant,
        selectedColor: selectedColor ?? this.selectedColor,
        step: step ?? this.step,
      );

  double get totalPrice =>
      (selectedVariant?.price ?? car.startingPrice);
}

class CarConfigNotifier extends StateNotifier<CarConfigState> {
  CarConfigNotifier(CarModel car)
      : super(CarConfigState(
          car: car,
          selectedVariant:
              car.variants.isNotEmpty ? car.variants.first : null,
          selectedColor: car.colors.isNotEmpty ? car.colors.first : null,
        ));

  void selectVariant(CarVariant variant) =>
      state = state.copyWith(selectedVariant: variant);

  void selectColor(CarColor color) =>
      state = state.copyWith(selectedColor: color);

  void nextStep() => state = state.copyWith(step: state.step + 1);
  void prevStep() =>
      state = state.copyWith(step: state.step > 0 ? state.step - 1 : 0);
}

final carConfigProvider = StateNotifierProvider.family<CarConfigNotifier,
    CarConfigState, CarModel>(
  (ref, car) => CarConfigNotifier(car),
);
