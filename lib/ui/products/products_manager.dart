import 'package:flutter/cupertino.dart';
import 'package:myshop/models/auth_token.dart';
import 'package:myshop/models/product.dart';
import 'package:myshop/services/products_service.dart';

class ProductsManager with ChangeNotifier {
  List<Product> _items = [];
  final ProductsService _productsService;

  ProductsManager([AuthToken? authToken])
      : _productsService = ProductsService(authToken);

  int get itemCount {
    return _items.length;
  }

  set authToken(AuthToken authToken) {
    _productsService.authToken = authToken;
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    _items = await _productsService.fetchProducts(filterByUser);
    notifyListeners();
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addProduct(Product product) async {
    final newProduct = await _productsService.addProduct(product);
    if (newProduct != null) {
      _items.add(newProduct);
      notifyListeners();
    }
  }

  void updateProduct(Product product) {
    final index = _items.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void toggleFavoriteProduct(Product product) {
    final savedStatus = product.isFavorite;
    product.isFavorite = !savedStatus;
  }

  void deleteProduct(String id) {
    final index = _items.indexWhere((element) => element.id == id);
    _items.removeAt(index);
    notifyListeners();
  }
}
