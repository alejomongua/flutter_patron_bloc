import 'dart:convert';

import 'package:patron_bloc/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductsProvider {
  final String _url = 'https://flutter-dev-a10cf-default-rtdb.firebaseio.com';

  Future<bool> create(Product product) async {
    if (product.id != null) return await update(product);

    final url = Uri.parse('$_url/products.json');

    final response = await http.post(url, body: productToJson(product));

    final decodedData = json.decode(response.body);

    print("Created");
    print(decodedData);

    return true;
  }

  Future<bool> update(Product product) async {
    if (product.id == null) return await create(product);

    final url = Uri.parse('$_url/products/${product.id}.json');

    final response = await http.put(url, body: productToJson(product));

    final decodedData = json.decode(response.body);

    print("Updated");
    print(decodedData);

    return true;
  }

  Future<List<Product>> index() async {
    final url = Uri.parse('$_url/products.json');

    final response = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(response.body);

    final List<Product> resultado = [];

    print("Listed data");
    print(decodedData);

    decodedData.forEach((key, value) {
      Product producto = Product.fromJson(value);
      producto.id = key;
      resultado.add(producto);
    });

    return resultado;
  }

  Future<bool> destroy(String id) async {
    final url = Uri.parse('$_url/products/$id.json');

    final response = await http.delete(url);

    final decodedData = json.decode(response.body);

    print("Deleted $id");
    print(decodedData);

    return true;
  }
}
