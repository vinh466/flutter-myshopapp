import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myshop/models/product.dart';
import 'package:myshop/ui/products/products_manager.dart';

class UserProductListTile extends StatelessWidget {
  final Product product;
  const UserProductListTile(
    this.product, {
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
      trailing: SizedBox(
          width: 100,
          child: Row(
            children: <Widget>[
              buildEditButton(context),
              buildDeleteButton(context),
            ],
          )),
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      color: Theme.of(context).errorColor,
      onPressed: () {
        context.read<ProductsManager>().deleteProduct(product.id!);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(
                'Product deleted',
                textAlign: TextAlign.center,
              ),
            ),
          );
      },
    );
  }

  Widget buildEditButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      color: Theme.of(context).primaryColor,
      onPressed: () {
        print('Go to edit product screen');
      },
    );
  }
}
