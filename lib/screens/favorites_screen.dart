import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Product> favoriteProducts;
  final Function(Product) onToggleFavorite;

  FavoritesScreen({
    required this.favoriteProducts,
    required this.onToggleFavorite,
  });

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Избранные продукты'),
      ),
      body: ListView.builder(
        itemCount: widget.favoriteProducts.length,
        itemBuilder: (context, index) {
          Product product = widget.favoriteProducts[index];
          return ListTile(
            leading: product.imageUrl.isNotEmpty
                ? Image.network(product.imageUrl, width: 50, height: 50, fit: BoxFit.cover)
                : SizedBox(width: 50, height: 50),
            title: Text(product.name),
            subtitle: Text(product.category),
            trailing: IconButton(
              icon: Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                widget.onToggleFavorite(product);
                setState(() {}); // Обновление списка избранного после удаления продукта
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(
                    product: product,
                    isFavorite: true,
                    onToggleFavorite: () {
                      widget.onToggleFavorite(product);
                      setState(() {}); // Обновление списка избранного после удаления продукта
                    },
                  ),
                ),
              ).then((_) {
                setState(() {}); // Обновление после возвращения с экрана деталей
              });
            },
          );
        },
      ),
    );
  }
}
