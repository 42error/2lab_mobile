import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  ProductDetailScreen({
    required this.product,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    widget.onToggleFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.product.imageUrl.isNotEmpty
                ? Image.network(widget.product.imageUrl, fit: BoxFit.cover)
                : SizedBox(height: 200),
            SizedBox(height: 16.0),
            Text('Категория: ${widget.product.category}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8.0),
            Text('Калории: ${widget.product.calories}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8.0),
            Text('Ингредиенты:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(widget.product.ingredients),
            SizedBox(height: 16.0),
            Text('Противопоказания:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(widget.product.contraindications),
          ],
        ),
      ),
    );
  }
}
