import 'package:flutter/material.dart';
import 'package:order_app/models/order.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  String strStatus = "";

  OrderTile(this.order);

  String getDescriptionStatus(int orderStatus) {
    switch (orderStatus) {
      case 1:
        strStatus = "WAITING_PAYMENT";
        break;
      case 2:
        strStatus = "PAID";
        break;
      case 3:
        strStatus = "SHIPPED";
        break;
      case 4:
        strStatus = "DELIVERED";
        break;
      case 5:
        strStatus = "CANCELED";
        break;
      default:
    }
    return strStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text(this.order.description),
              subtitle: Text(
                getDescriptionStatus(this.order.orderStatus),
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ))
        ],
      ),
    );
  }
}
