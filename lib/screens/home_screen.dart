import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import 'product_detail_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<Product> _products = [];
  List<Product> _favorites = [];
  bool _isLoading = false;
  TextEditingController _searchController = TextEditingController();

  void _searchProducts(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Product> products = await apiService.searchProducts(query);
      setState(() {
        _products = products;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _products = [];
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleFavorite(Product product) {
    setState(() {
      if (_favorites.contains(product)) {
        _favorites.remove(product);
      } else {
        _favorites.add(product);
      }
    });
  }

  void _refreshFavorites() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Справочник продуктов'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(
                    favoriteProducts: _favorites,
                    onToggleFavorite: _toggleFavorite,
                  ),
                ),
              ).then((_) {
                _refreshFavorites(); // Обновление после возвращения с экрана избранных
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Введите название продукта',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchProducts(_searchController.text);
                  },
                ),
              ),
            ),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  Product product = _products[index];
                  bool isFavorite = _favorites.contains(product);
                  return ListTile(
                    leading: product.imageUrl.isNotEmpty
                        ? Image.network(product.imageUrl, width: 50, height: 50, fit: BoxFit.cover)
                        : SizedBox(width: 50, height: 50),
                    title: Text(product.name),
                    subtitle: Text(product.category),
                    trailing: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                      onPressed: () {
                        _toggleFavorite(product);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            product: product,
                            isFavorite: isFavorite,
                            onToggleFavorite: () {
                              _toggleFavorite(product);
                              setState(() {}); // Обновление после изменения избранного
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
            ),
          ],
        ),
      ),
    );
  }
}
