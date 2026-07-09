class Product {
  final int id;
  final String title;
  final double price;
  final String? description;
  final String? imageUrl;
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.description,
    this.imageUrl,
    required this.rating,
  });

  // Fungsi untuk mengubah format JSON dari Supabase menjadi Object Dart
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      imageUrl: json['image_url'],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}