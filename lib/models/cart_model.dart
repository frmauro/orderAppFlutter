import 'package:order_app/models/product.dart';
import 'package:order_app/models/user_models.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;
  List<Product> products = [];

  CartModel(this.user);

  void addCartItem(Product product) {
    products.add(product);

    //parte que envia requisição para a Api para gravar no banco de dados

    notifyListeners();
  }

  void removeCartItem(Product product) {
    //parte que envia requisição para a Api para remover do banco de dados

    products.remove(product);
    notifyListeners();
  }
}
