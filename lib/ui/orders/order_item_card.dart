import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myshop/models/order_item.dart';
import 'package:intl/intl.dart';

class OrderItemCard extends StatefulWidget {
  final OrderItem order;
  const OrderItemCard(this.order, {super.key});

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          buildOrderSummary(),
          const Divider(height: 0, color: Colors.grey),
          if (_expanded) buildOrderDetail()
        ],
      ),
    );
  }

  buildOrderSummary() {
    return ListTile(
      title: Text('\$${widget.order.amount}'),
      subtitle: Text(
        DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
      ),
      trailing: IconButton(
        onPressed: () {
          setState(() {
            _expanded = !_expanded;
          });
        },
        icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
      ),
      onTap: () {
        setState(() {
          _expanded = !_expanded;
        });
      },
    );
  }

  buildOrderDetail() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      height: min(widget.order.productCount * 20.0 + 18, 100),
      color: Colors.grey[100],
      child: ListView(
        padding: const EdgeInsets.only(left: 5),
        children: <Widget>[
          ...widget.order.products
              .map(
                (e) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      e.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${e.quantity}x \$${e.price}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
