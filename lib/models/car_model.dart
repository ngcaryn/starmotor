class CarColor {
  final String name;
  final int colorValue;
  final String? imageUrl;

  const CarColor({
    required this.name,
    required this.colorValue,
    this.imageUrl,
  });

  factory CarColor.fromJson(Map<String, dynamic> json) => CarColor(
        name: json['name'] as String,
        colorValue: json['color_value'] as int,
        imageUrl: json['image_url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'color_value': colorValue,
        'image_url': imageUrl,
      };
}

class CarVariant {
  final String id;
  final String name;
  final double price;
  final String range;
  final String? acceleration;
  final String? topSpeed;
  final String? peakPower;

  const CarVariant({
    required this.id,
    required this.name,
    required this.price,
    required this.range,
    this.acceleration,
    this.topSpeed,
    this.peakPower,
  });

  factory CarVariant.fromJson(Map<String, dynamic> json) => CarVariant(
        id: json['id'] as String,
        name: json['name'] as String,
        price: (json['price'] as num).toDouble(),
        range: json['range'] as String,
        acceleration: json['acceleration'] as String?,
        topSpeed: json['top_speed'] as String?,
        peakPower: json['peak_power'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'range': range,
        'acceleration': acceleration,
        'top_speed': topSpeed,
        'peak_power': peakPower,
      };
}

class CarSpecs {
  final String length;
  final String width;
  final String height;
  final String wheelbase;
  final String seats;
  final String driveType;
  final String batteryCapacity;

  const CarSpecs({
    required this.length,
    required this.width,
    required this.height,
    required this.wheelbase,
    required this.seats,
    required this.driveType,
    required this.batteryCapacity,
  });

  factory CarSpecs.fromJson(Map<String, dynamic> json) => CarSpecs(
        length: json['length'] as String,
        width: json['width'] as String,
        height: json['height'] as String,
        wheelbase: json['wheelbase'] as String,
        seats: json['seats'] as String,
        driveType: json['drive_type'] as String,
        batteryCapacity: json['battery_capacity'] as String,
      );

  Map<String, dynamic> toJson() => {
        'length': length,
        'width': width,
        'height': height,
        'wheelbase': wheelbase,
        'seats': seats,
        'drive_type': driveType,
        'battery_capacity': batteryCapacity,
      };
}

class CarModel {
  final String id;
  final String name;
  final String series;
  final String? coverImage;
  final List<String> images;
  final double startingPrice;
  final String fuelType;
  final String? tagline;
  final List<String> highlights;
  final List<CarVariant> variants;
  final List<CarColor> colors;
  final CarSpecs? specs;

  const CarModel({
    required this.id,
    required this.name,
    required this.series,
    this.coverImage,
    this.images = const [],
    required this.startingPrice,
    required this.fuelType,
    this.tagline,
    this.highlights = const [],
    this.variants = const [],
    this.colors = const [],
    this.specs,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        id: json['id'] as String,
        name: json['name'] as String,
        series: json['series'] as String,
        coverImage: json['cover_image'] as String?,
        images: List<String>.from(json['images'] as List? ?? []),
        startingPrice: (json['starting_price'] as num).toDouble(),
        fuelType: json['fuel_type'] as String,
        tagline: json['tagline'] as String?,
        highlights: List<String>.from(json['highlights'] as List? ?? []),
        variants: (json['variants'] as List? ?? [])
            .map((v) => CarVariant.fromJson(v as Map<String, dynamic>))
            .toList(),
        colors: (json['colors'] as List? ?? [])
            .map((c) => CarColor.fromJson(c as Map<String, dynamic>))
            .toList(),
        specs: json['specs'] != null
            ? CarSpecs.fromJson(json['specs'] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'series': series,
        'cover_image': coverImage,
        'images': images,
        'starting_price': startingPrice,
        'fuel_type': fuelType,
        'tagline': tagline,
        'highlights': highlights,
        'variants': variants.map((v) => v.toJson()).toList(),
        'colors': colors.map((c) => c.toJson()).toList(),
        'specs': specs?.toJson(),
      };
}
