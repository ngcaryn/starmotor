class ShippingAddress {
  final String name;
  final String phone;
  final String province;
  final String city;
  final String district;
  final String detail;

  const ShippingAddress({
    required this.name,
    required this.phone,
    required this.province,
    required this.city,
    required this.district,
    required this.detail,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        name: json['name'] as String,
        phone: json['phone'] as String,
        province: json['province'] as String,
        city: json['city'] as String,
        district: json['district'] as String,
        detail: json['detail'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'province': province,
        'city': city,
        'district': district,
        'detail': detail,
      };

  String get fullAddress => '$province$city$district$detail';
}

enum OrderStatus {
  pending,
  paid,
  processing,
  shipped,
  delivered,
  cancelled,
  refunding,
  refunded,
}

class OrderModel {
  final String id;
  final String userId;
  final List<Map<String, dynamic>> items;
  final double totalAmount;
  final OrderStatus status;
  final ShippingAddress? shippingAddress;
  final String? trackingNumber;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.status,
    this.shippingAddress,
    this.trackingNumber,
    required this.createdAt,
    this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'] as String,
        userId: json['user_id'] as String,
        items: List<Map<String, dynamic>>.from(json['items'] as List),
        totalAmount: (json['total_amount'] as num).toDouble(),
        status: OrderStatus.values.firstWhere(
          (s) => s.name == json['status'],
          orElse: () => OrderStatus.pending,
        ),
        shippingAddress: json['shipping_address'] != null
            ? ShippingAddress.fromJson(
                json['shipping_address'] as Map<String, dynamic>)
            : null,
        trackingNumber: json['tracking_number'] as String?,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'] as String)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'items': items,
        'total_amount': totalAmount,
        'status': status.name,
        'shipping_address': shippingAddress?.toJson(),
        'tracking_number': trackingNumber,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  String get statusLabel {
    switch (status) {
      case OrderStatus.pending:
        return '待付款';
      case OrderStatus.paid:
        return '已付款';
      case OrderStatus.processing:
        return '处理中';
      case OrderStatus.shipped:
        return '已发货';
      case OrderStatus.delivered:
        return '已收货';
      case OrderStatus.cancelled:
        return '已取消';
      case OrderStatus.refunding:
        return '退款中';
      case OrderStatus.refunded:
        return '已退款';
    }
  }
}
