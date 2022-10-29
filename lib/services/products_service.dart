import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myshop/models/auth_token.dart';
import 'package:myshop/models/product.dart';
import 'package:myshop/services/firebase_service.dart';

class ProductsService extends FirebaseService {
  ProductsService(AuthToken? authToken) : super(authToken);

  Future<List<Product>> fetchProducts([bool filterByUser = false]) async {
    final List<Product> products = [];

    try {
      final filters =
          filterByUser ? 'orderBy="creatorId"&equalTo+"$userId"' : '';

      final productUrl =
          Uri.parse('$databaseUrl/products.json?auth=$token&$filters');

      final response = await http.get(productUrl);

      final productsMap = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        print('fetchProducts 1');
        print(productsMap['error']);
        return products;
      }
      final userFavoriteUrl =
          Uri.parse('$databaseUrl/userFavorites/$userId.json?auth=$token');
      final userFavoriteResponse = await http.get(userFavoriteUrl);
      final userFavoriteMap = json.decode(userFavoriteResponse.body);

      productsMap.forEach((productId, product) {
        final isFavorite = (userFavoriteMap == null)
            ? false
            : (userFavoriteMap[productId] ?? false);

        products.add(
          Product.fromJson({
            'id': productId,
            ...product,
          }).copyWith(isFavorite: isFavorite),
        );
      });
      return products;
    } catch (error) {
      print('fetchProducts 2');
      print(error);
      return products;
    }
  }

  Future<Product?> addProduct(Product product) async {
    try {
      final url = Uri.parse('$databaseUrl/products.json?auth=$token');
      final response = await http.post(
        url,
        body: json.encode(
          product.toJson()
            ..addAll({
              'creatorId': userId,
            }),
        ),
      );

      if (response.statusCode != 200) {
        print('addProduct $userId');

        throw Exception(json.decode(response.body)['error']);
      }
      print('addProduct success');
      return product.copyWith(
        id: json.decode(response.body)['name'],
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> updateProduct(Product product) async {
    try {
      final url =
          Uri.parse('$databaseUrl/products/${product.id}.json?auth=$token');
      final response = await http.patch(
        url,
        body: json.encode(product.toJson()),
      );

      if (response.statusCode != 200) {
        print('updateProduct $userId');

        throw Exception(json.decode(response.body)['error']);
      }
      print('updateProduct success');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      final url = Uri.parse('$databaseUrl/products/$id.json?auth=$token');
      final response = await http.delete(url);

      if (response.statusCode != 200) {
        print('addProduct $userId');

        throw Exception(json.decode(response.body)['error']);
      }
      print('addProduct success');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> saveFavoriteStatus(Product product) async {
    try {
      final url = Uri.parse(
          '$databaseUrl/userFavorites/$userId/${product.id}.json?auth=$token');
      final response = await http.put(
        url,
        body: json.encode(
          product.isFavorite,
        ),
      );

      if (response.statusCode != 200) {
        print('saveFavoriteStatus $userId');
        throw Exception(json.decode(response.body)['error']);
      }
      print('saveFavoriteStatus success');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
