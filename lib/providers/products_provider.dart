import 'dart:convert';

import 'package:patron_bloc/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductsProvider {
  final String _url = 'https://flutter-dev-a10cf-default-rtdb.firebaseio.com';

  Future<bool> create(Product product) async {
    final url = Uri.parse('$_url/products.json');

    final response = await http.post(url, body: productToJson(product));

    final decodedData = json.decode(response.body);

    print(decodedData);

    return true;
  }

  Future<List<Product>> index() async {
    final url = Uri.parse('$_url/products.json');

    final response = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(response.body);

    final List<Product> resultado = [];

    print(decodedData);

    decodedData.forEach((key, value) {
      Product producto = Product.fromJson(value);
      producto.id = key;
      resultado.add(producto);
    });

    return resultado;
  }
}
