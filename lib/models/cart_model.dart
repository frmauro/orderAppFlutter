import 'package:flutter/cupertino.dart';
import 'package:order_app/models/product.dart';
import 'package:order_app/models/user_models.dart';
import 'package:scoped_model/scoped_model.dart';

// Esse é o IP do wifi
const urlApi = "http://192.168.15.61:80/orders";

class CartModel extends Model {
  String status;

  UserModel user;
  List<Product> products = [];

  CartModel(this.user, this.status);

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(Product product) {
    products.add(product);

    //parte que envia requisição para a Api para gravar no banco de dados

    notifyListeners();
  }

  void removeCartItem(Product product) {
    //parte que envia requisição para a Api para remover do banco de dados

    products.remove(product);
    notifyListeners();
  }
}
