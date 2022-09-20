import 'package:myshop/models/cart_item.dart';
import 'package:myshop/models/order_item.dart';

class OrdersManager {
  final List<OrderItem> _orders = [
    OrderItem(id: 'o1', amount: 79.97, products: [
      CartItem(
        id: 'ci',
        title: 'Red Shirt',
        price: 29.99,
        quantity: 2,
      ),
      CartItem(
        id: 'ci2',
        title: 'Blue Shirt',
        price: 19.99,
        quantity: 1,
      )
    ]),
    OrderItem(id: 'o2', amount: 99.97, products: [
      CartItem(
        id: 'ci3',
        title: 'Yellow Shirt',
        price: 29.99,
        quantity: 2,
      ),
      CartItem(
        id: 'ci4',
        title: 'Green Shirt',
        price: 39.99,
        quantity: 1,
      )
    ]),
  ];

  int get orderCount {
    return _orders.length;
  }

  List<OrderItem> get orders {
    return [..._orders];
  }
}
