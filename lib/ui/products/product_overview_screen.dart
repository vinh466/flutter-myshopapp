import 'package:flutter/material.dart';
import 'package:myshop/ui/cart/cart_manager.dart';
import 'package:myshop/ui/cart/cart_screen.dart';
import 'package:myshop/ui/products/product_grid_tile.dart';
import 'package:myshop/ui/products/products_grid.dart';
import 'package:myshop/ui/products/products_manager.dart';
import 'package:myshop/ui/products/top_right_badge.dart';
import 'package:myshop/ui/shared/app_drawer.dart';
import 'package:provider/provider.dart';

enum FilterOptions { favorite, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorite = ValueNotifier<bool>(false);
  late Future<void> _fetchProducts;

  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          buildShoppingCartIcon(),
          buildProductFilterMenu(),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _fetchProducts,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ValueListenableBuilder<bool>(
              valueListenable: _showOnlyFavorite,
              builder: ((context, showOnlyFavorite, child) {
                return ProductsGrid(showOnlyFavorite);
              }),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(builder: (ctx, value, child) {
      return TopRightBage(
        data: value.productCount,
        child: IconButton(
            onPressed: () {
              Navigator.of(ctx).pushNamed(CartScreen.routeName);
            },
            icon: const Icon(Icons.shopping_cart)),
      );
    });
  }

  Widget buildProductFilterMenu() {
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue) {
        setState(() {
          if (selectedValue == FilterOptions.favorite) {
            _showOnlyFavorite.value = true;
          } else {
            _showOnlyFavorite.value = false;
          }
        });
      },
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
            value: FilterOptions.favorite, child: Text('Only Favorite')),
        const PopupMenuItem(value: FilterOptions.all, child: Text('Show All')),
      ],
    );
  }
}
