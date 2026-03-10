class ServiceCenter {
  final String id;
  final String name;
  final String address;
  final String phone;
  final double? latitude;
  final double? longitude;
  final String? distance;

  const ServiceCenter({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    this.latitude,
    this.longitude,
    this.distance,
  });

  factory ServiceCenter.fromJson(Map<String, dynamic> json) => ServiceCenter(
        id: json['id'] as String,
        name: json['name'] as String,
        address: json['address'] as String,
        phone: json['phone'] as String,
        latitude: (json['latitude'] as num?)?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble(),
        distance: json['distance'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'phone': phone,
        'latitude': latitude,
        'longitude': longitude,
        'distance': distance,
      };
}

class ServiceBooking {
  final String id;
  final String userId;
  final String serviceType;
  final String serviceCenterId;
  final DateTime appointmentTime;
  final String status;
  final String? notes;
  final DateTime createdAt;

  const ServiceBooking({
    required this.id,
    required this.userId,
    required this.serviceType,
    required this.serviceCenterId,
    required this.appointmentTime,
    required this.status,
    this.notes,
    required this.createdAt,
  });

  factory ServiceBooking.fromJson(Map<String, dynamic> json) => ServiceBooking(
        id: json['id'] as String,
        userId: json['user_id'] as String,
        serviceType: json['service_type'] as String,
        serviceCenterId: json['service_center_id'] as String,
        appointmentTime:
            DateTime.parse(json['appointment_time'] as String),
        status: json['status'] as String,
        notes: json['notes'] as String?,
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'service_type': serviceType,
        'service_center_id': serviceCenterId,
        'appointment_time': appointmentTime.toIso8601String(),
        'status': status,
        'notes': notes,
        'created_at': createdAt.toIso8601String(),
      };
}

class ServiceModel {
  final String id;
  final String name;
  final String? description;
  final String? iconName;
  final String? imageUrl;
  final double? price;
  final int estimatedDurationMinutes;

  const ServiceModel({
    required this.id,
    required this.name,
    this.description,
    this.iconName,
    this.imageUrl,
    this.price,
    this.estimatedDurationMinutes = 60,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String?,
        iconName: json['icon_name'] as String?,
        imageUrl: json['image_url'] as String?,
        price: (json['price'] as num?)?.toDouble(),
        estimatedDurationMinutes:
            (json['estimated_duration_minutes'] as int?) ?? 60,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'icon_name': iconName,
        'image_url': imageUrl,
        'price': price,
        'estimated_duration_minutes': estimatedDurationMinutes,
      };
}
