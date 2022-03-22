import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:order_app/models/product.dart';
import 'package:order_app/tiles/product_tile.dart';

// Esse é o IP do wifi
const urlApi = "http://192.168.15.61:80//getAllProduct";

class ProductsTab extends StatelessWidget {
  final _productController = TextEditingController();
  List<Product> _products = [];

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  Future<String> getAllProducts() async {
    http.Response res =
        await http.get(Uri.parse(urlApi), headers: _setHeaders());
    if (res.statusCode == 200) {
      //print(res.body);
      return res.body;
    }
    return "erro";
  }

  //@override
  //void initState() {
  //super.initState();
  //loadProducts();
  //}

  Future<List<Product>> loadProducts() {
    return this.getAllProducts().then((body) {
      var jsonProducts = json.decode(body) as List;
      //List<dynamic> list;
      _products.clear();

      jsonProducts.forEach((e) {
        _products.add(Product.fromJson(e));
      });

      return _products;
      //print("TESTE 0001");
      //print(_products);
      //setState(() {
      //_products = _products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            // var divideTiles = ListTile.divideTiles(
            //         tiles: _products.map((p) {
            //           return ProductTile(p);
            //         }).toList(),
            //         color: Colors.grey[500])
            //     .toList();

            return ListView.builder(
                padding: EdgeInsets.all(4.0),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  return ProductTile(_products[index]);
                });
          }
        });
  }
}
