import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:order_app/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login.dart';

const urlApiLogIn = "http://192.168.15.61:80/user";

class UserModel extends Model {
  late User user;
  late Login login;
  Map<String, dynamic> userData = Map();
  bool isLoading = false;

  void signUp() {}

  Future<User> sigIn(Login login) async {
    isLoading = true;
    notifyListeners();

    //await Future.delayed(Duration(seconds: 3));
    //Future<String> saveUser(Login login) async {

    final http.Response response = await http.post(
      Uri.parse(urlApiLogIn),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'email': login.email, 'password': login.password}),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      isLoading = false;
      notifyListeners();
      //print(response.body);
      var jsonUser = json.decode(response.body) as List;

      jsonUser.forEach((e) {
        user = User.fromJson(e);
      });

      return user;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load user');
    }
  }

  void signOut() {
    user.token = "";
    notifyListeners();
  }

  void recoverPass() {}

  bool isLoggedIn() {
    return user.token.isNotEmpty;
  }
}
