import 'package:flutter/material.dart';
import 'package:myshop/ui/screens.dart';

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
        home: const ProductsOverviewScreen(),
        routes: {
          CartScreen.routeName: (ctx) => const CartScreen(),
          OrderScreen.routeName: (ctx) => const OrderScreen(),
          UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == ProductDetailScreen.routeName) {
            final productId = settings.arguments as String;
            return MaterialPageRoute(builder: (ctx) {
              return ProductDetailScreen(
                ProductsManager().findById(productId),
              );
            });
          }
        });
  }
}
