class ProductModel {
  final String id;
  final String name;
  final String nameChinese;
  final String description;
  final String categoryId;
  final String categoryName;
  final double price;
  final double? originalPrice;
  final List<String> imageUrls;
  final String? thumbnailUrl;
  final int stockCount;
  final double rating;
  final int reviewCount;
  final List<String> tags;
  final bool isFeatured;
  final bool isOnSale;
  final DateTime createdAt;

  const ProductModel({
    required this.id,
    required this.name,
    required this.nameChinese,
    required this.description,
    required this.categoryId,
    required this.categoryName,
    required this.price,
    this.originalPrice,
    this.imageUrls = const [],
    this.thumbnailUrl,
    this.stockCount = 0,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.tags = const [],
    this.isFeatured = false,
    this.isOnSale = false,
    required this.createdAt,
  });

  bool get inStock => stockCount > 0;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      nameChinese: json['name_chinese'] as String,
      description: json['description'] as String,
      categoryId: json['category_id'] as String,
      categoryName: json['category_name'] as String,
      price: (json['price'] as num).toDouble(),
      originalPrice: (json['original_price'] as num?)?.toDouble(),
      imageUrls: List<String>.from(json['image_urls'] as List? ?? []),
      thumbnailUrl: json['thumbnail_url'] as String?,
      stockCount: json['stock_count'] as int? ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['review_count'] as int? ?? 0,
      tags: List<String>.from(json['tags'] as List? ?? []),
      isFeatured: json['is_featured'] as bool? ?? false,
      isOnSale: json['is_on_sale'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_chinese': nameChinese,
      'description': description,
      'category_id': categoryId,
      'category_name': categoryName,
      'price': price,
      'original_price': originalPrice,
      'image_urls': imageUrls,
      'thumbnail_url': thumbnailUrl,
      'stock_count': stockCount,
      'rating': rating,
      'review_count': reviewCount,
      'tags': tags,
      'is_featured': isFeatured,
      'is_on_sale': isOnSale,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class ProductCategory {
  final String id;
  final String name;
  final String nameChinese;
  final String? iconUrl;
  final int productCount;

  const ProductCategory({
    required this.id,
    required this.name,
    required this.nameChinese,
    this.iconUrl,
    this.productCount = 0,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      nameChinese: json['name_chinese'] as String,
      iconUrl: json['icon_url'] as String?,
      productCount: json['product_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_chinese': nameChinese,
      'icon_url': iconUrl,
      'product_count': productCount,
    };
  }
}

class CartItemModel {
  final String id;
  final String productId;
  final ProductModel product;
  final int quantity;
  final DateTime addedAt;

  const CartItemModel({
    required this.id,
    required this.productId,
    required this.product,
    required this.quantity,
    required this.addedAt,
  });

  double get totalPrice => product.price * quantity;

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as String,
      productId: json['product_id'] as String,
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      addedAt: DateTime.parse(json['added_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product': product.toJson(),
      'quantity': quantity,
      'added_at': addedAt.toIso8601String(),
    };
  }

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      id: id,
      productId: productId,
      product: product,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt,
    );
  }
}
