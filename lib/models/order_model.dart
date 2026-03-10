enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  delivered,
  cancelled,
  refunded,
}

enum OrderType {
  car,
  mall,
  service,
}

class OrderModel {
  final String id;
  final String userId;
  final OrderType type;
  final OrderStatus status;
  final double totalAmount;
  final String? paymentMethod;
  final bool isPaid;
  final List<OrderItemModel> items;
  final ShippingAddress? shippingAddress;
  final String? trackingNumber;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? estimatedDelivery;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.status,
    required this.totalAmount,
    this.paymentMethod,
    this.isPaid = false,
    this.items = const [],
    this.shippingAddress,
    this.trackingNumber,
    this.notes,
    required this.createdAt,
    this.updatedAt,
    this.estimatedDelivery,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      type: OrderType.values.byName(json['type'] as String),
      status: OrderStatus.values.byName(json['status'] as String),
      totalAmount: (json['total_amount'] as num).toDouble(),
      paymentMethod: json['payment_method'] as String?,
      isPaid: json['is_paid'] as bool? ?? false,
      items: (json['items'] as List? ?? [])
          .map((i) => OrderItemModel.fromJson(i as Map<String, dynamic>))
          .toList(),
      shippingAddress: json['shipping_address'] != null
          ? ShippingAddress.fromJson(json['shipping_address'] as Map<String, dynamic>)
          : null,
      trackingNumber: json['tracking_number'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      estimatedDelivery: json['estimated_delivery'] != null
          ? DateTime.parse(json['estimated_delivery'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type.name,
      'status': status.name,
      'total_amount': totalAmount,
      'payment_method': paymentMethod,
      'is_paid': isPaid,
      'items': items.map((i) => i.toJson()).toList(),
      'shipping_address': shippingAddress?.toJson(),
      'tracking_number': trackingNumber,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'estimated_delivery': estimatedDelivery?.toIso8601String(),
    };
  }
}

class OrderItemModel {
  final String id;
  final String itemId;
  final String itemName;
  final String? itemImageUrl;
  final double unitPrice;
  final int quantity;

  const OrderItemModel({
    required this.id,
    required this.itemId,
    required this.itemName,
    this.itemImageUrl,
    required this.unitPrice,
    required this.quantity,
  });

  double get subtotal => unitPrice * quantity;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] as String,
      itemId: json['item_id'] as String,
      itemName: json['item_name'] as String,
      itemImageUrl: json['item_image_url'] as String?,
      unitPrice: (json['unit_price'] as num).toDouble(),
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item_id': itemId,
      'item_name': itemName,
      'item_image_url': itemImageUrl,
      'unit_price': unitPrice,
      'quantity': quantity,
    };
  }
}

class ShippingAddress {
  final String id;
  final String recipientName;
  final String phone;
  final String province;
  final String city;
  final String district;
  final String street;
  final String? postalCode;
  final bool isDefault;

  const ShippingAddress({
    required this.id,
    required this.recipientName,
    required this.phone,
    required this.province,
    required this.city,
    required this.district,
    required this.street,
    this.postalCode,
    this.isDefault = false,
  });

  String get fullAddress => '$province$city$district$street';

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      id: json['id'] as String,
      recipientName: json['recipient_name'] as String,
      phone: json['phone'] as String,
      province: json['province'] as String,
      city: json['city'] as String,
      district: json['district'] as String,
      street: json['street'] as String,
      postalCode: json['postal_code'] as String?,
      isDefault: json['is_default'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipient_name': recipientName,
      'phone': phone,
      'province': province,
      'city': city,
      'district': district,
      'street': street,
      'postal_code': postalCode,
      'is_default': isDefault,
    };
  }
}
