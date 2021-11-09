import 'package:flutter/material.dart';
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
                children: <Widget>[
                  Text(
                    product.description,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
                  ),
                  Text("Preço R\$: ${product.price}",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor, 
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(onPressed: (){}, icon: Icon(Icons.remove)),
                      Text(product.amount),
                      IconButton(onPressed: (){}, icon: Icon(Icons.add)),
                      FlatButton(
                        onPressed: (){}, 
                        child: Text("Remover"),
                         textColor: Colors.grey[500],
                        )
                    ],
                  )
                ],
              ),
            )
            )
        ],
      )
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: _buildContent(),
    );
  }
}
