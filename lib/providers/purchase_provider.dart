import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/car_model.dart';

final carListProvider =
    StateNotifierProvider<CarListNotifier, AsyncValue<List<CarModel>>>((ref) {
  return CarListNotifier();
});

class CarListNotifier extends StateNotifier<AsyncValue<List<CarModel>>> {
  CarListNotifier() : super(const AsyncValue.loading()) {
    loadCars();
  }

  Future<void> loadCars() async {
    state = const AsyncValue.loading();
    try {
      // Mock data - replace with actual API call
      await Future.delayed(const Duration(milliseconds: 800));
      state = AsyncValue.data(_getMockCars());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  List<CarModel> _getMockCars() {
    return [
      CarModel(
        id: 'car_001',
        name: 'Starmotor S7',
        nameChinese: '星驰S7',
        brand: 'Starmotor',
        series: 'S',
        type: 'suv',
        fuelType: 'electric',
        basePrice: 298000,
        imageUrls: ['https://picsum.photos/seed/car_s7/800/450'],
        thumbnailUrl: 'https://picsum.photos/seed/car_s7/400/225',
        specs: const CarSpecs(
          range: 620,
          batteryCapacity: 90,
          horsepower: 450,
          acceleration: 4.2,
          topSpeed: 200,
          seats: 5,
          driveType: 'AWD',
        ),
        variants: [
          const CarVariant(
            id: 'var_001',
            name: '基础版',
            price: 298000,
            features: ['标准续航', '单电机', '基础辅助驾驶'],
          ),
          const CarVariant(
            id: 'var_002',
            name: '进阶版',
            price: 338000,
            features: ['长续航', '双电机', '高级辅助驾驶', '全景天窗'],
          ),
          const CarVariant(
            id: 'var_003',
            name: '旗舰版',
            price: 388000,
            features: ['超长续航', '四驱', 'L2+辅助驾驶', '空气悬挂', 'HUD'],
          ),
        ],
        availableColors: [
          const CarColor(
            id: 'col_001',
            name: 'White',
            nameChinese: '珍珠白',
            colorHex: 0xFFF5F5F5,
          ),
          const CarColor(
            id: 'col_002',
            name: 'Black',
            nameChinese: '曜石黑',
            colorHex: 0xFF1A1A1A,
          ),
          const CarColor(
            id: 'col_003',
            name: 'Blue',
            nameChinese: '星空蓝',
            colorHex: 0xFF1E4D8C,
            additionalPrice: 5000,
          ),
        ],
        highlights: ['620km超长续航', '零百4.2秒', 'L2+辅助驾驶', '宽敞豪华内饰'],
      ),
      CarModel(
        id: 'car_002',
        name: 'Starmotor X9',
        nameChinese: '星驰X9',
        brand: 'Starmotor',
        series: 'X',
        type: 'suv',
        fuelType: 'hybrid',
        basePrice: 428000,
        imageUrls: ['https://picsum.photos/seed/car_x9/800/450'],
        thumbnailUrl: 'https://picsum.photos/seed/car_x9/400/225',
        specs: const CarSpecs(
          range: 1200,
          horsepower: 680,
          acceleration: 3.8,
          topSpeed: 230,
          seats: 6,
          driveType: 'AWD',
        ),
        variants: [
          const CarVariant(
            id: 'var_004',
            name: '豪华版',
            price: 428000,
            features: ['增程模式', '6座布局', '豪华内饰'],
          ),
          const CarVariant(
            id: 'var_005',
            name: '超豪华版',
            price: 488000,
            features: ['增程模式', '6座全皮内饰', '按摩座椅', '冰箱', '智能驾驶'],
          ),
        ],
        availableColors: [
          const CarColor(
            id: 'col_004',
            name: 'Silver',
            nameChinese: '流光银',
            colorHex: 0xFFC0C0C0,
          ),
        ],
        highlights: ['1200km综合续航', '6座旗舰SUV', '一键智能驾驶', '豪华商务内饰'],
      ),
    ];
  }
}

final selectedCarProvider = StateProvider<CarModel?>((ref) => null);

final carConfigProvider =
    StateNotifierProvider<CarConfigNotifier, CarConfiguration>((ref) {
  return CarConfigNotifier();
});

class CarConfiguration {
  final String? carId;
  final String? variantId;
  final String? colorId;
  final Map<String, bool> options;

  const CarConfiguration({
    this.carId,
    this.variantId,
    this.colorId,
    this.options = const {},
  });

  CarConfiguration copyWith({
    String? carId,
    String? variantId,
    String? colorId,
    Map<String, bool>? options,
  }) {
    return CarConfiguration(
      carId: carId ?? this.carId,
      variantId: variantId ?? this.variantId,
      colorId: colorId ?? this.colorId,
      options: options ?? this.options,
    );
  }
}

class CarConfigNotifier extends StateNotifier<CarConfiguration> {
  CarConfigNotifier() : super(const CarConfiguration());

  void selectCar(String carId) {
    state = state.copyWith(carId: carId, variantId: null, colorId: null);
  }

  void selectVariant(String variantId) {
    state = state.copyWith(variantId: variantId);
  }

  void selectColor(String colorId) {
    state = state.copyWith(colorId: colorId);
  }

  void toggleOption(String optionId) {
    final options = Map<String, bool>.from(state.options);
    options[optionId] = !(options[optionId] ?? false);
    state = state.copyWith(options: options);
  }

  void reset() {
    state = const CarConfiguration();
  }
}
