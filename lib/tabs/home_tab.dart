import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:order_app/models/product.dart';

// Esse é o IP do wifi
const urlApi = "http://192.168.15.61:80/product";

class HomeTab extends StatelessWidget {
  final _productController = TextEditingController();
  List<Product> _product = [];

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  Future<String> getAllProducts() async {
    http.Response res = await http.get(urlApi, headers: _setHeaders());
    if (res.statusCode == 200) {
      //print(res.body);
      return res.body;
    }
    return "erro";
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildBoryBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 211, 118, 130),
            Color.fromARGB(255, 253, 184, 168)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        );

    return Stack(
      children: <Widget>[
        _buildBoryBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Novidades"),
                centerTitle: true,
              ),
            ),
            FutureBuilder(
              future: getAllProducts(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                else {
                  print(snapshot.data);
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: Container(),
                    ),
                  );
                }
              },
            )
          ],
        )
      ],
    );
  }
}
