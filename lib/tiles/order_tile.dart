import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final int id;

  OrderTile(this.id);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(id.toString()),
    );
  }
}
