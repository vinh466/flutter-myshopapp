import 'package:flutter/material.dart';
import 'package:myshop/ui/products/product_grid_tile.dart';
import 'package:myshop/ui/products/products_grid.dart';

enum FilterOptions { favorite, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          buildProductFilterMenu(),
          buildShoppingCartIcon(),
        ],
      ),
      body: ProductsGrid(_showOnlyFavorite),
    );
  }

  Widget buildShoppingCartIcon() {
    return IconButton(
        onPressed: () {
          print('Go to cart screen');
        },
        icon: const Icon(Icons.shopping_cart));
  }

  Widget buildProductFilterMenu() {
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue) {
        setState(() {
          if (selectedValue == FilterOptions.favorite) {
            _showOnlyFavorite = true;
          } else {
            _showOnlyFavorite = false;
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
