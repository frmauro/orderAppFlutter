import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:order_app/models/order.dart';
import 'package:order_app/models/user_models.dart';
import 'package:order_app/screens/login_screen.dart';
import 'package:order_app/tiles/order_tile.dart';

// Esse é o IP do wifi
const urlApi = "http://192.168.15.61:80/orders";

//http://192.168.15.61:80/findByUserId/611aa80245c2ed2212c3ec3d

class OrdersTab extends StatelessWidget {
  List<Order> _orders = [];

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  Future<String> getAllOrdersByUserId(String id) async {
    String url = urlApi + "/findByUserId/" + id;
    http.Response res = await http.get(Uri.parse(url), headers: _setHeaders());
    if (res.statusCode == 200) {
      //print(res.body);
      return res.body;
    }
    return "erro";
  }

  Future<List<Order>> AllOrdersByUserId(String id) {
    return this.getAllOrdersByUserId(id).then((body) {
      var jsonOrders = json.decode(body) as List;
      _orders.clear();
      jsonOrders.forEach((e) {
        _orders.add(Order.fromJson(e));
      });
      return _orders;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).isLoggedIn()) {
      String id = UserModel.of(context).user.id;
      return FutureBuilder(
        future: AllOrdersByUserId(id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: _orders.map((o) => OrderTile(o.id)).toList(),
            );
          }
        },
      );
    } else {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.view_list,
              size: 80.0,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              "Faça login para acompanhar!",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16.0,
            ),
            RaisedButton(
              child: Text(
                "Entrar",
                style: TextStyle(fontSize: 18.0),
              ),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            )
          ],
        ),
      );
    }
  }
}
