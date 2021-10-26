import 'package:scoped_model/scoped_model.dart';

const urlApiLogIn = "http://192.168.15.61:80/user";

class UserModel extends Model {
  bool isLoading = false;

  void signUp() {}

  void sigIn() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 3));

    isLoading = false;
    notifyListeners();
  }

  void recoverPass() {}

  bool isLoggedIn() {
    return true;
  }
}
