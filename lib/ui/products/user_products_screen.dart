import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myshop/ui/products/products_manager.dart';
import 'package:myshop/ui/products/user_product_list_tile.dart';
import 'package:myshop/ui/shared/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsManager = ProductsManager();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          buildAddButton(),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async => print('Refresh products'),
        child: buildUserProductListView(productsManager),
      ),
    );
  }

  Widget buildAddButton() {
    return IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          print('Go to edit product screen');
        });
  }

  Widget buildUserProductListView(ProductsManager productsManager) {
    return ListView.builder(
      itemCount: productsManager.itemCount,
      itemBuilder: (ctx, i) => Column(
        children: [
          UserProductListTile(productsManager.items[i]),
          const Divider(),
        ],
      ),
    );
  }
}
