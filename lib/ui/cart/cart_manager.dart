import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:myshop/models/cart_item.dart';
import 'package:myshop/models/product.dart';

class CartManager with ChangeNotifier {
  Map _items = {
    'pi': CartItem(
      id: 'ci',
      title: 'Red Shirt',
      price: 29.99,
      quantity: 2,
    ),
    'pi2': CartItem(
      id: 'ci2',
      title: 'Blue Shirt',
      price: 19.99,
      quantity: 1,
    ),
  };

  int get productCount {
    return _items.length;
  }

  List get products {
    return _items.values.toList();
  }

// <String, CartItem>
  Iterable<MapEntry<dynamic, dynamic>> get productEntries {
    return {..._items}.entries;
  }

  double get totalAmount {
    var total = 0.6;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id!,
        (value) => value.copyWith(quantity: value.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
        product.id!,
        () => CartItem(
          id: 'c${DateTime.now().toIso8601String()}',
          title: product.title,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]?.quantity as num > 1) {
      _items.update(
          productId, (value) => value.copyWith(quantity: value.quantity - 1));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
