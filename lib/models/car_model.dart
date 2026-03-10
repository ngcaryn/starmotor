class CarModel {
  final String id;
  final String name;
  final String nameChinese;
  final String brand;
  final String series;
  final String type; // suv, sedan, etc.
  final String fuelType; // electric, hybrid, gasoline
  final double basePrice;
  final double? promotionalPrice;
  final List<String> imageUrls;
  final String? thumbnailUrl;
  final CarSpecs specs;
  final List<CarVariant> variants;
  final List<CarColor> availableColors;
  final List<String> highlights;
  final bool isAvailable;
  final DateTime? availableFrom;

  const CarModel({
    required this.id,
    required this.name,
    required this.nameChinese,
    required this.brand,
    required this.series,
    required this.type,
    required this.fuelType,
    required this.basePrice,
    this.promotionalPrice,
    this.imageUrls = const [],
    this.thumbnailUrl,
    required this.specs,
    this.variants = const [],
    this.availableColors = const [],
    this.highlights = const [],
    this.isAvailable = true,
    this.availableFrom,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] as String,
      name: json['name'] as String,
      nameChinese: json['name_chinese'] as String,
      brand: json['brand'] as String,
      series: json['series'] as String,
      type: json['type'] as String,
      fuelType: json['fuel_type'] as String,
      basePrice: (json['base_price'] as num).toDouble(),
      promotionalPrice: (json['promotional_price'] as num?)?.toDouble(),
      imageUrls: List<String>.from(json['image_urls'] as List? ?? []),
      thumbnailUrl: json['thumbnail_url'] as String?,
      specs: CarSpecs.fromJson(json['specs'] as Map<String, dynamic>),
      variants: (json['variants'] as List? ?? [])
          .map((v) => CarVariant.fromJson(v as Map<String, dynamic>))
          .toList(),
      availableColors: (json['available_colors'] as List? ?? [])
          .map((c) => CarColor.fromJson(c as Map<String, dynamic>))
          .toList(),
      highlights: List<String>.from(json['highlights'] as List? ?? []),
      isAvailable: json['is_available'] as bool? ?? true,
      availableFrom: json['available_from'] != null
          ? DateTime.parse(json['available_from'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_chinese': nameChinese,
      'brand': brand,
      'series': series,
      'type': type,
      'fuel_type': fuelType,
      'base_price': basePrice,
      'promotional_price': promotionalPrice,
      'image_urls': imageUrls,
      'thumbnail_url': thumbnailUrl,
      'specs': specs.toJson(),
      'variants': variants.map((v) => v.toJson()).toList(),
      'available_colors': availableColors.map((c) => c.toJson()).toList(),
      'highlights': highlights,
      'is_available': isAvailable,
      'available_from': availableFrom?.toIso8601String(),
    };
  }
}

class CarSpecs {
  final double? range; // km (for electric)
  final double? batteryCapacity; // kWh
  final int? horsepower;
  final double? acceleration; // 0-100 km/h seconds
  final double? topSpeed;
  final double? length;
  final double? width;
  final double? height;
  final double? wheelbase;
  final int? seats;
  final String? driveType; // FWD, RWD, AWD

  const CarSpecs({
    this.range,
    this.batteryCapacity,
    this.horsepower,
    this.acceleration,
    this.topSpeed,
    this.length,
    this.width,
    this.height,
    this.wheelbase,
    this.seats,
    this.driveType,
  });

  factory CarSpecs.fromJson(Map<String, dynamic> json) {
    return CarSpecs(
      range: (json['range'] as num?)?.toDouble(),
      batteryCapacity: (json['battery_capacity'] as num?)?.toDouble(),
      horsepower: json['horsepower'] as int?,
      acceleration: (json['acceleration'] as num?)?.toDouble(),
      topSpeed: (json['top_speed'] as num?)?.toDouble(),
      length: (json['length'] as num?)?.toDouble(),
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      wheelbase: (json['wheelbase'] as num?)?.toDouble(),
      seats: json['seats'] as int?,
      driveType: json['drive_type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'range': range,
      'battery_capacity': batteryCapacity,
      'horsepower': horsepower,
      'acceleration': acceleration,
      'top_speed': topSpeed,
      'length': length,
      'width': width,
      'height': height,
      'wheelbase': wheelbase,
      'seats': seats,
      'drive_type': driveType,
    };
  }
}

class CarVariant {
  final String id;
  final String name;
  final double price;
  final List<String> features;

  const CarVariant({
    required this.id,
    required this.name,
    required this.price,
    this.features = const [],
  });

  factory CarVariant.fromJson(Map<String, dynamic> json) {
    return CarVariant(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      features: List<String>.from(json['features'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'features': features,
    };
  }
}

class CarColor {
  final String id;
  final String name;
  final String nameChinese;
  final int colorHex;
  final double? additionalPrice;

  const CarColor({
    required this.id,
    required this.name,
    required this.nameChinese,
    required this.colorHex,
    this.additionalPrice,
  });

  factory CarColor.fromJson(Map<String, dynamic> json) {
    return CarColor(
      id: json['id'] as String,
      name: json['name'] as String,
      nameChinese: json['name_chinese'] as String,
      colorHex: json['color_hex'] as int,
      additionalPrice: (json['additional_price'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_chinese': nameChinese,
      'color_hex': colorHex,
      'additional_price': additionalPrice,
    };
  }
}
