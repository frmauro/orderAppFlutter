import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:order_app/models/product.dart';
import 'package:order_app/models/user_models.dart';
import 'package:scoped_model/scoped_model.dart';

import 'order.dart';

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

  double getProductsTotal() {
    double total = 0.0;
    for (Product p in items) {
      total += p.quatity * double.parse(p.price);
    }
    return total;
  }

  Future<String> finishOrder() async {
    String id = "";
    if (items.length == 0) return id;

    //Parte que irá enviar um pedido para a API(orderApi) para que o mesmo seja persistido
    //         OrderDto structure    *******************
    //     private Long id;
    //     private String description;
    //     private String moment;
    //     private Integer orderStatus;
    //     private String userId;
    //     private Set<OrderItemDto> items = new HashSet<>();

    //         OrderItemDto structure    **************
    // private Long id;
    // private String description;
    // private Integer quantity;
    // private Double price;
    // private Integer productId;

    var order = new Order(description);
    order.moment = "";
    order.userId = user.user.id;
    order.orderStatus = 1;
    order.items = items;

    var t = jsonEncode(<String, dynamic>{
      'description': order.description,
      'moment': order.moment,
      'orderStatus': order.orderStatus.toString(),
      'userId': order.userId,
      'items': jsonEncode(order.items)
    });

    isLoading = true;
    notifyListeners();

    final http.Response response = await http.post(
      Uri.parse(urlApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'description': order.description,
        'moment': order.moment,
        'orderStatus': order.orderStatus.toString(),
        'userId': order.userId,
        'items': jsonEncode(order.items)
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(response.body);
      items.clear();
      isLoading = false;
      notifyListeners();
      return id;
      //return "operation success";
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load order');
    }
  }
}
