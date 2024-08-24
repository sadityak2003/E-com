class Product {
  final String title;
  final String? image;
  final double price;
  final String description;
  final double rating;
  final String brand;
  final String category;
  final double oldPrice;
  final int stock;
  final String availabilityStatus;
  final int itemsPurchased;
  final double discountPercentage;

  Product({
    required this.title,
    this.image,
    required this.price,
    required this.description,
    required this.rating,
    required this.brand,
    required this.category,
    required this.oldPrice,
    required this.stock,
    required this.availabilityStatus,
    required this.itemsPurchased,
    required this.discountPercentage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final double price = (json['price'] as num?)?.toDouble() ?? 0.0;
    final double discountPercentage = (json['discountPercentage'] as num?)?.toDouble() ?? 0.0;

    return Product(
      title: json['title'] ?? 'Unknown',
      image: json['images'] != null && json['images'].isNotEmpty
          ? json['images'][0] as String?
          : null,
      price: price,
      description: json['description'] ?? 'No description',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      brand: json['brand'] ?? 'Unknown Brand',
      category: json['category'] ?? 'Unknown Category',
      oldPrice: price * (1 + (discountPercentage / 100)),
      stock: json['stock'] ?? 0,
      availabilityStatus: json['availabilityStatus'] ?? 'Unknown Status',
      itemsPurchased: json['itemsPurchased'] ?? 0,
      discountPercentage: discountPercentage,
    );
  }
}
