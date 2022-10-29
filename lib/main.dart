import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myshop/ui/auth/auth_manager.dart';
import 'package:myshop/ui/auth/auth_screen.dart';
import 'package:myshop/ui/products/edit_product_screen.dart';
import 'package:myshop/ui/screens.dart';
import 'package:myshop/ui/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyShop());
}

class MyShop extends StatelessWidget {
  const MyShop({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthManager(),
        ),
        ChangeNotifierProxyProvider<AuthManager, ProductsManager>(
          create: (ctx) => ProductsManager(),
          update: (ctx, authManager, productsManager) {
            productsManager!.authToken = authManager.authToken!;
            return productsManager;
          },
        ),
        // ChangeNotifierProvider(
        //   create: (ctx) => ProductsManager(),
        // ),
        ChangeNotifierProvider(
          create: (ctx) => CartManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrdersManager(),
        ),
      ],
      child: Consumer<AuthManager>(
        builder: (ctx, authManager, child) {
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
              // home: const ProductsOverviewScreen(),
              home: authManager.isAuth
                  ? ProductsOverviewScreen()
                  : FutureBuilder(
                      future: authManager.tryAutoLogin(),
                      builder: ((context, snapshot) =>
                          snapshot.connectionState == ConnectionState.waiting
                              ? const SplashScreen()
                              : const AuthScreen()),
                    ),
              routes: {
                CartScreen.routeName: (ctx) => const CartScreen(),
                OrderScreen.routeName: (ctx) => const OrderScreen(),
                UserProductsScreen.routeName: (ctx) =>
                    const UserProductsScreen(),
              },
              onGenerateRoute: (settings) {
                if (settings.name == ProductDetailScreen.routeName) {
                  final productId = settings.arguments as String;
                  return MaterialPageRoute(
                    builder: (ctx) {
                      return ProductDetailScreen(
                        ctx.read<ProductsManager>().findById(productId),
                      );
                    },
                  );
                }
                if (settings.name == EditProductScreen.routeName) {
                  final productId = settings.arguments as String?;
                  return MaterialPageRoute(
                    builder: (ctx) {
                      return EditProductScreen(
                        productId != null
                            ? ctx.read<ProductsManager>().findById(productId)
                            : null,
                      );
                    },
                  );
                }
                return null;
              });
        },
      ),
    );
  }
}
