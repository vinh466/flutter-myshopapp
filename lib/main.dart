import 'package:flutter/material.dart';
import 'package:myshop/ui/products/product_detail_screen.dart';
import 'package:myshop/ui/products/product_grid_tile.dart';
import 'package:myshop/ui/products/product_overview_screen.dart';
import 'package:myshop/ui/products/products_manager.dart';
import 'package:myshop/ui/products/user_products_screen.dart';

void main() {
  runApp(const MyShop());
}

class MyShop extends StatelessWidget {
  const MyShop({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: Colors.deepOrange,
          primary: Colors.purple,
        ),
      ),
      home: SafeArea(
        child: UserProductsScreen(),
      ),
    );
  }
}
