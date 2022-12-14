import 'package:flutter/material.dart';
import 'package:myshop/ui/orders/order_manager.dart';
import 'package:provider/provider.dart';
import 'package:myshop/ui/cart/cart_item_card.dart';
import 'package:myshop/ui/cart/cart_manager.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Cart'),
        ),
        body: Column(
          children: [
            buildCartSummary(cart, context),
            const SizedBox(
              height: 10,
            ),
            Expanded(child: buildCartDetail(cart)),
          ],
        ));
  }

  buildCartDetail(CartManager cart) {
    return ListView(
      children: cart.productEntries
          .map((e) => CartItemCard(productId: e.key, cardItem: e.value))
          .toList(),
    );
  }

  buildCartSummary(CartManager cart, BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Total',
                style: TextStyle(fontSize: 20),
              ),
              const Spacer(),
              Chip(
                label: Text(
                  '\$${cart.totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.headline6?.color,
                  ),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              TextButton(
                  onPressed: cart.totalAmount <= 0
                      ? null
                      : () {
                          context
                              .read<OrdersManager>()
                              .addOrder(cart.products, cart.totalAmount);
                          context.read<CartManager>().clear();
                        },
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  child: const Text('Order Now'))
            ],
          ),
        ));
  }
}
