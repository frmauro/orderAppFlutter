import 'package:order_app/models/product.dart';

enum OrderStatus { WAITING_PAYMENT, PAID, SHIPPED, DELIVERED, CANCELED }

class Order {
  int id = 0;
  String description;
  String moment = "";
  int orderStatus = 0; //int.parse(OrderStatus.WAITING_PAYMENT.toString());
  String userId = "";
  List<Product> items = [];

  Order({required this.description});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(description: json["description"]);
  }

  Map toJson() => {
        'id': id,
        'description': description,
        'moment': moment,
        'orderStatus': orderStatus,
        'userId': userId
      };
}
