class CartItemModel {
  final String id;
  final String productId;
  final String productName;
  final String? productImage;
  final double price;
  final int quantity;

  const CartItemModel({
    required this.id,
    required this.productId,
    required this.productName,
    this.productImage,
    required this.price,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        id: json['id'] as String,
        productId: json['product_id'] as String,
        productName: json['product_name'] as String,
        productImage: json['product_image'] as String?,
        price: (json['price'] as num).toDouble(),
        quantity: json['quantity'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_id': productId,
        'product_name': productName,
        'product_image': productImage,
        'price': price,
        'quantity': quantity,
      };

  CartItemModel copyWith({int? quantity}) => CartItemModel(
        id: id,
        productId: productId,
        productName: productName,
        productImage: productImage,
        price: price,
        quantity: quantity ?? this.quantity,
      );

  double get subtotal => price * quantity;
}

class ProductModel {
  final String id;
  final String name;
  final String? description;
  final String? coverImage;
  final List<String> images;
  final double price;
  final double? originalPrice;
  final String category;
  final int stock;
  final double rating;
  final int reviewCount;
  final bool isFeatured;

  const ProductModel({
    required this.id,
    required this.name,
    this.description,
    this.coverImage,
    this.images = const [],
    required this.price,
    this.originalPrice,
    required this.category,
    required this.stock,
    this.rating = 0,
    this.reviewCount = 0,
    this.isFeatured = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String?,
        coverImage: json['cover_image'] as String?,
        images: List<String>.from(json['images'] as List? ?? []),
        price: (json['price'] as num).toDouble(),
        originalPrice: json['original_price'] != null
            ? (json['original_price'] as num).toDouble()
            : null,
        category: json['category'] as String,
        stock: json['stock'] as int,
        rating: (json['rating'] as num?)?.toDouble() ?? 0,
        reviewCount: (json['review_count'] as int?) ?? 0,
        isFeatured: (json['is_featured'] as bool?) ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'cover_image': coverImage,
        'images': images,
        'price': price,
        'original_price': originalPrice,
        'category': category,
        'stock': stock,
        'rating': rating,
        'review_count': reviewCount,
        'is_featured': isFeatured,
      };

  bool get isOnSale =>
      originalPrice != null && originalPrice! > price;
  bool get inStock => stock > 0;
}
