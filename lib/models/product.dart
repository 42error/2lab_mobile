class Product {
  final String name;
  final String category;
  final int calories;
  final String ingredients;
  final String contraindications;
  final String imageUrl;

  Product({
    required this.name,
    required this.category,
    required this.calories,
    required this.ingredients,
    required this.contraindications,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['product_name'] ?? 'No name',
      category: json['categories'] ?? 'No category',
      calories: int.tryParse(json['nutriments']?['energy-kcal_100g']?.toString() ?? '0') ?? 0,
      ingredients: json['ingredients_text'] ?? 'No ingredients',
      contraindications: json['allergens'] ?? 'No contraindications',
      imageUrl: json['image_url'] ?? '',
    );
  }
}
