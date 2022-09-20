import 'package:flutter/material.dart';
import 'package:myshop/ui/orders/orders_screen.dart';
import 'package:myshop/ui/products/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            AppBar(
              title: const Text('Hello Friend!'),
              automaticallyImplyLeading: false,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.shop),
              title: const Text('Shop'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Orders'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrderScreen.routeName);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Manage Products'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(UserProductsScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
