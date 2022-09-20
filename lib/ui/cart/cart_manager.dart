import 'package:myshop/models/cart_item.dart';

class CartManager {
  final Map _items = {
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
}
