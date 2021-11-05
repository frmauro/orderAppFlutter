import 'package:flutter/material.dart';
import 'package:order_app/models/product.dart';
import 'package:order_app/models/user_models.dart';
import 'package:order_app/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {
  final Product product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final Product product;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.description),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.description,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price}",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (UserModel.of(context).isLoggedIn()) {
                          // add ao carrinhho
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                        }
                      },
                      child: Text(
                          UserModel.of(context).isLoggedIn()
                              ? "Add ao Carrinho"
                              : "Entre para comprar",
                          style: TextStyle(fontSize: 18.0)),
                      color: primaryColor,
                      textColor: Colors.white,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
