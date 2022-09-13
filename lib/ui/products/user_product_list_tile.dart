import 'package:flutter/material.dart';
import 'package:myshop/models/product.dart';

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
      onPressed: () async {
        print('Delete a product');
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
