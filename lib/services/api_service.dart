import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  final String baseUrl = 'https://world.openfoodfacts.org/cgi/search.pl';

  Future<List<Product>> searchProducts(String query) async {
    final response = await http.get(Uri.parse('$baseUrl?search_terms=$query&search_simple=1&action=process&json=1'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List productsJson = data['products'];
      return productsJson.map((productJson) => Product.fromJson(productJson)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
