import 'package:flutter/cupertino.dart';
import 'package:order_app/models/product.dart';
import 'package:order_app/models/user_models.dart';
import 'package:scoped_model/scoped_model.dart';

// Esse é o IP do wifi
const urlApi = "http://192.168.15.61:80/orders";

class CartModel extends Model {
  int id = 0;
  String description;
  String moment = "";
  String userId = "";
  UserModel user;
  List<Product> items = [];

  bool isLoading = false;

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

  void decCartItem(Product product) {
    product.quatity--;
    //aqui talvez possa ser que tenha que atualizar a quantidade do produto na API no Servidor
    notifyListeners();
  }

  void incCartItem(Product product) {
    product.quatity++;
    //aqui talvez possa ser que tenha que atualizar a quantidade do produto na API no Servidor
    notifyListeners();
  }
}
