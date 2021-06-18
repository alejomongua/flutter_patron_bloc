import 'dart:async';
import 'dart:io';
import 'package:rxdart/rxdart.dart';

import 'package:patron_bloc/models/product_model.dart';
import 'package:patron_bloc/providers/products_provider.dart';

class ProductsBloc {
  final _productosController = BehaviorSubject<List<Product>>();

  final _loadingController = BehaviorSubject<bool>();

  final _productsProvider = ProductsProvider();

  // Function(List<Product>) get changeEmail => _productosController.sink.add;
  // Function(bool) get changePassword => _loadingController.sink.add;

  Stream<List<Product>> get productosStream => _productosController.stream;
  Stream<bool> get loading => _loadingController.stream;

  void loadProducts() async {
    final products = await _productsProvider.index();

    _productosController.sink.add(products);
  }

  void addProduct(Product product) async {
    _loadingController.sink.add(true);
    await _productsProvider.create(product);
    loadProducts();
    _loadingController.sink.add(false);
  }

  Future<String?> addPhoto(File photo) async {
    _loadingController.sink.add(true);
    final photoUrl = await _productsProvider.uploadImage(photo);
    loadProducts();
    _loadingController.sink.add(false);
    return photoUrl;
  }

  void editProduct(Product product) async {
    _loadingController.sink.add(true);
    await _productsProvider.update(product);
    loadProducts();
    _loadingController.sink.add(false);
  }

  void removeProduct(String productId) async {
    await _productsProvider.destroy(productId);
  }

  get currentEmail => _productosController.value;
  get currentPassword => _loadingController.value;

  dispose() {
    _productosController.close();
    _loadingController.close();
  }
}
