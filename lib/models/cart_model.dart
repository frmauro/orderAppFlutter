import 'package:order_app/models/product.dart';
import 'package:order_app/models/user_models.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;
  List<Product> products = [];

  CartModel(this.user);
}
