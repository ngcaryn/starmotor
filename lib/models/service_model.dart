enum ServiceType {
  maintenance,
  repair,
  inspection,
  carWash,
  tireChange,
  other,
}

enum BookingStatus {
  pending,
  confirmed,
  inProgress,
  completed,
  cancelled,
}

class ServiceModel {
  final String id;
  final String name;
  final String nameChinese;
  final String description;
  final ServiceType type;
  final double price;
  final int estimatedDurationMinutes;
  final bool isAvailable;
  final List<String> includedItems;

  const ServiceModel({
    required this.id,
    required this.name,
    required this.nameChinese,
    required this.description,
    required this.type,
    required this.price,
    required this.estimatedDurationMinutes,
    this.isAvailable = true,
    this.includedItems = const [],
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      nameChinese: json['name_chinese'] as String,
      description: json['description'] as String,
      type: ServiceType.values.byName(json['type'] as String),
      price: (json['price'] as num).toDouble(),
      estimatedDurationMinutes: json['estimated_duration_minutes'] as int,
      isAvailable: json['is_available'] as bool? ?? true,
      includedItems: List<String>.from(json['included_items'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_chinese': nameChinese,
      'description': description,
      'type': type.name,
      'price': price,
      'estimated_duration_minutes': estimatedDurationMinutes,
      'is_available': isAvailable,
      'included_items': includedItems,
    };
  }
}

class ServiceBooking {
  final String id;
  final String userId;
  final String serviceId;
  final String serviceName;
  final String serviceCenterId;
  final String serviceCenterName;
  final BookingStatus status;
  final DateTime appointmentTime;
  final String? vehicleInfo;
  final String? notes;
  final double totalAmount;
  final DateTime createdAt;

  const ServiceBooking({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.serviceName,
    required this.serviceCenterId,
    required this.serviceCenterName,
    required this.status,
    required this.appointmentTime,
    this.vehicleInfo,
    this.notes,
    required this.totalAmount,
    required this.createdAt,
  });

  factory ServiceBooking.fromJson(Map<String, dynamic> json) {
    return ServiceBooking(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      serviceId: json['service_id'] as String,
      serviceName: json['service_name'] as String,
      serviceCenterId: json['service_center_id'] as String,
      serviceCenterName: json['service_center_name'] as String,
      status: BookingStatus.values.byName(json['status'] as String),
      appointmentTime: DateTime.parse(json['appointment_time'] as String),
      vehicleInfo: json['vehicle_info'] as String?,
      notes: json['notes'] as String?,
      totalAmount: (json['total_amount'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'service_id': serviceId,
      'service_name': serviceName,
      'service_center_id': serviceCenterId,
      'service_center_name': serviceCenterName,
      'status': status.name,
      'appointment_time': appointmentTime.toIso8601String(),
      'vehicle_info': vehicleInfo,
      'notes': notes,
      'total_amount': totalAmount,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class ServiceCenter {
  final String id;
  final String name;
  final String nameChinese;
  final String address;
  final String city;
  final double latitude;
  final double longitude;
  final String phone;
  final String? email;
  final Map<String, String> openingHours;
  final List<String> availableServices;
  final double rating;

  const ServiceCenter({
    required this.id,
    required this.name,
    required this.nameChinese,
    required this.address,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.phone,
    this.email,
    this.openingHours = const {},
    this.availableServices = const [],
    this.rating = 0.0,
  });

  factory ServiceCenter.fromJson(Map<String, dynamic> json) {
    return ServiceCenter(
      id: json['id'] as String,
      name: json['name'] as String,
      nameChinese: json['name_chinese'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      phone: json['phone'] as String,
      email: json['email'] as String?,
      openingHours: Map<String, String>.from(json['opening_hours'] as Map? ?? {}),
      availableServices: List<String>.from(json['available_services'] as List? ?? []),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_chinese': nameChinese,
      'address': address,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'phone': phone,
      'email': email,
      'opening_hours': openingHours,
      'available_services': availableServices,
      'rating': rating,
    };
  }
}
