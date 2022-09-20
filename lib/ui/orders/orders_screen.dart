import 'package:flutter/material.dart';
import 'package:myshop/ui/orders/order_item_card.dart';
import 'package:myshop/ui/orders/order_manager.dart';
import 'package:myshop/ui/shared/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersManager = OrdersManager();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: ordersManager.orderCount,
        itemBuilder: (ctx, i) => OrderItemCard(ordersManager.orders[i]),
      ),
    );
  }
}
