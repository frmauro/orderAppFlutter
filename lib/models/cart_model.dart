import 'package:flutter/cupertino.dart';
import 'package:order_app/models/product.dart';
import 'package:order_app/models/user_models.dart';
import 'package:scoped_model/scoped_model.dart';

// Esse é o IP do wifi
const urlApi = "http://192.168.15.61:80/orders";

enum OrderStatus { WAITING_PAYMENT, PAID, SHIPPED, DELIVERED, CANCELED }

class CartModel extends Model {
  int id = 0;
  String description;
  String moment = "";
  int orderStatus = int.parse(OrderStatus.WAITING_PAYMENT.toString());
  String userId = "";
  UserModel user;
  List<Product> items = [];

  CartModel(this.user, this.description);

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(Product product) {
    items.add(product);

    //parte que envia requisição para a Api para gravar no banco de dados

    notifyListeners();
  }

  void removeCartItem(Product product) {
    //parte que envia requisição para a Api para remover do banco de dados

    items.remove(product);
    notifyListeners();
  }
}
