import 'package:flutter/material.dart';
import 'package:order_app/models/cart_model.dart';
import 'package:order_app/models/product.dart';

class CartTile extends StatelessWidget {
  final Product product;

  CartTile(this.product);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      return Row(
        children: <Widget>[
          Expanded(
              child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  product.description,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
                ),
                Text(
                  "Preço R\$: ${product.price}",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      onPressed: int.parse(product.amount) > 1
                          ? () {
                              CartModel.of(context).decCartItem(product);
                            }
                          : null,
                      color: Theme.of(context).primaryColor,
                      icon: Icon(Icons.remove),
                    ),
                    Text(product.quatity.toString()),
                    IconButton(
                      onPressed: () {
                        CartModel.of(context).incCartItem(product);
                      },
                      color: Theme.of(context).primaryColor,
                      icon: Icon(Icons.add),
                    ),
                    FlatButton(
                      onPressed: () {
                        CartModel.of(context).removeCartItem(product);
                      },
                      child: Text("Remover"),
                      textColor: Colors.grey[500],
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: _buildContent(),
    );
  }
}
