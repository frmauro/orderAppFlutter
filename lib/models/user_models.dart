import 'package:order_app/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

const urlApiLogIn = "http://192.168.15.61:80/user";

class UserModel extends Model {
  late User user;
  Map<String, dynamic> userData = Map();
  bool isLoading = false;

  void signUp() {}

  void sigIn() async {
    isLoading = true;
    notifyListeners();

    //await Future.delayed(Duration(seconds: 3));

// Future<String> saveUser(User user) async {
//     final http.Response response = await http.post(
//       urlApiCreate,
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'name': user.name,
//         'email': user.email,
//         'password': user.password,
//         'token': "123",
//         'userType': user.userType,
//         'status': user.status
//       }),
//     );

//     if (response.statusCode == 200) {
//       // If the server did return a 201 CREATED response,
//       // then parse the JSON.
//       print(response.body);
//       return "operation success";
//     } else {
//       // If the server did not return a 201 CREATED response,
//       // then throw an exception.
//       throw Exception('Failed to load user');
//     }
//   }

    isLoading = false;
    notifyListeners();
  }

  void recoverPass() {}

  bool isLoggedIn() {
    return true;
  }
}
