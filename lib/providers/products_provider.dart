import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:patron_bloc/models/product_model.dart';
import 'package:http/http.dart' as http;

// El archivo secrets es ignorado por git, en él únicamente hay definidas tres
// constantes: FIREBASE_DB_URL, CLOUDINARY_API_KEY, CLOUDINARY_API_SECRET y
// CLOUDINARY_CLOUD_ID
import 'package:patron_bloc/secrets.dart';

class ProductsProvider {
  // Las constantes están definidas en el archivo secrets que no se encuentra
  // en el repo
  final Cloudinary _cloudinary = Cloudinary(
    CLOUDINARY_API_KEY,
    CLOUDINARY_API_SECRET,
    CLOUDINARY_CLOUD_ID,
  );

  Future<bool> create(Product product) async {
    if (product.id != null) return await update(product);

    final url = Uri.parse('$FIREBASE_DB_URL/products.json');

    final response = await http.post(url, body: productToJson(product));

    final decodedData = json.decode(response.body);

    print("Created");
    print(decodedData);

    return true;
  }

  Future<bool> update(Product product) async {
    if (product.id == null) return await create(product);

    final url = Uri.parse('$FIREBASE_DB_URL/products/${product.id}.json');

    final productMap = product.toJson();
    productMap.remove('id');

    final response = await http.put(url, body: json.encode(productMap));

    final decodedData = json.decode(response.body);

    print("Updated");
    print(decodedData);

    return true;
  }

  Future<List<Product>> index() async {
    final url = Uri.parse('$FIREBASE_DB_URL/products.json');

    final response = await http.get(url);

    final Map<String, dynamic>? decodedData = json.decode(response.body);

    if (decodedData == null) return [];

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
    final url = Uri.parse('$FIREBASE_DB_URL/products/$id.json');

    final response = await http.delete(url);

    final decodedData = json.decode(response.body);

    print("Deleted $id");
    print(decodedData);

    return true;
  }

  Future<String?> uploadImage(File file) async {
    final response = await _cloudinary.uploadFile(
      filePath: file.path,
      resourceType: CloudinaryResourceType.image,
      folder: '/products',
    );

    if (!response.isSuccessful) {
      return null;
    }

    print('Uploaded image');
    print(response.secureUrl);

    return response.secureUrl;
  }
}
