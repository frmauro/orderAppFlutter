import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:order_app/models/product.dart';
import 'package:order_app/models/user_models.dart';
import 'package:scoped_model/scoped_model.dart';

import 'order.dart';

// Esse é o IP do wifi
const urlApiCreateOrder = "http://192.168.15.61:80/CreateOrder";
const urlApiUpdateAmount = "http://192.168.15.61:80/UpdateAmount";

class CartModel extends Model {
  int id = 0;
  String description = "";
  String moment = "";
  String userId = "";
  int quantity = 0;
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
    product.amount = product.quatity.toString();
    //aqui talvez possa ser que tenha que atualizar a quantidade do produto na API no Servidor
    notifyListeners();
  }

  void incCartItem(Product product) {
    product.quatity++;
    product.amount = product.quatity.toString();
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

    var order = new Order(description, 1);
    order.moment = "";
    order.userId = user.user.id;
    order.orderStatus = 1;
    order.items = items;

    // var jsonOrder = jsonEncode({
    //   "id": 0,
    //   "description": "Order 012",
    //   "orderStatus": 1,
    //   "userId": "611aa80245c2ed2212c3ec3d",
    //   "items": [
    //     {
    //       "id": 1,
    //       "description": "Product 001",
    //       "quantity": 1,
    //       "price": 200,
    //       "productId": 1
    //     }
    //   ]
    // });

    var t = jsonEncode({
      'id': 0,
      'description': order.description,
      'status': order.orderStatus,
      'userId': order.userId,
      'items': order.items
    });

    isLoading = true;
    notifyListeners();

    final http.Response response = await http.post(
      Uri.parse(urlApiCreateOrder),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: t,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(response.body);
      //aqui será feito uma requisião para atuaizar a quantidade de produtos
      return updateAmount(order.items).then((result) {
        isLoading = false;
        items.clear();
        notifyListeners();
        return result;
      });

      //return result;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      isLoading = false;
      notifyListeners();
      throw Exception('Failed to load order');
    }
  }

  Future<String> updateAmount(List<Product> items) async {
    String result = "";
    List<dynamic> products = [];

    //[{"id": 1, "description": "Product 001", "amount": 1, "price": "200", "status": "Active"}]

    products = items
        .map((e) => {'id': e.id, 'Quantity': int.parse(e.amount)})
        .toList();

    var t = jsonEncode({"items": products});

    final http.Response response = await http.post(
      Uri.parse(urlApiUpdateAmount),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: t,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(response.body);
      return result;
    } else {
      throw Exception('Failed to update product amount');
    }
  }
}
