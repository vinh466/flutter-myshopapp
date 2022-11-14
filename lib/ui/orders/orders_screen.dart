import 'package:flutter/material.dart';
import 'package:myshop/ui/orders/order_item_card.dart';
import 'package:myshop/ui/orders/order_manager.dart';
import 'package:myshop/ui/shared/app_drawer.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: Consumer<OrdersManager>(
        builder: (ctx, value, child) {
          return ListView.builder(
            itemCount: value.orderCount,
            itemBuilder: (ctx, i) => OrderItemCard(value.orders[i]),
          );
        },
      ),
    );
  }
}

// {
  // "Chats" : {
  //   "-Lsfsd234xda" : {
  //     "lastMessageSent" : "-LrDEBo1-Message",
  //     "members" : [ "-LrDEBoLokW-5mhaT3ys", "-LrDEBoLokW-5mhaT3yz" ],
  //     "more_properties" : "goes here"
  //   }
  // },
  // "Users" : {
  //   "-LrDEBoLokW-5mhaT3ys" : {
  //     "id" : "-LrDEBoLokW-5mhaT3ys",
  //     "userDisplayName" : "Qadir Hussain",
  //     "userEmail" : "XXXXX.XXXX@gmail.com",
  //     "userPhotoUrl" : "https://lh3.googleusercontent.com/a-/AAuE7XXXXXXXXX"
  //   },
  //   "-LrDEBoLokW-5mhaT3yz" : {
  //     "id" : "-LrDEBoLokW-5mhaT3yz",
  //     "userDisplayName" : "Ishaq Bhojani",
  //     "userEmail" : "XXXXXXX.XXXXXX@gmail.com",
  //     "userPhotoUrl" : "https://lh3.googleusercontent.com/a-/AAuE7mB3KTbXXXXXXXX"
  //   }
  // },
  // "chatMessages" : {
  //   "-Lsfsd234xda" : {
  //     "-LrDEBo-MessageUID" : {
  //       "message" : "Hi there!",
  //       "messageDate" : "10/10/2019",
  //       "messageTime" : "10:16pm",
  //       "sentBy" : "-LrDEBoLokW-5mhaT3ys"
  //     },
  //     "-LrDEBo1-MessageUID" : {
  //       "message" : "Hello",
  //       "messageDate" : "10/10/2019",
  //       "messageTime" : "10:17pm",
  //       "sentBy" : "-LrDEBoLokW-5mhaT3yz"
  //     }
  //   }
  // },
  // "userChats" : {
  //   "-LrDEBoLokW-5mhaT3ys" : {
  //     "0" : "-Lsfsd234xda",
  //     "1" : "-Lsfsd234xda1",
  //     "chatUID" : "-Lsfsd234xda"
  //   }
  // }
// }
