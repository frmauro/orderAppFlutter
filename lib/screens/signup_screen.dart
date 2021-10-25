import 'package:flutter/material.dart';

class SigUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "Nome Completo"),
              validator: (text) {
                if (text!.isEmpty) return "Nome inválido";
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "E-mail"),
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                if (text!.isEmpty || !text.contains("@"))
                  return "E-mail inválido";
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "password"),
              obscureText: true,
              validator: (text) {
                if (text!.isEmpty || text.length < 3)
                  return "Password inválido";
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            SizedBox(
              height: 44.0,
              child: RaisedButton(
                child: Text(
                  "Criar Conta",
                  style: TextStyle(fontSize: 18.0),
                ),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}