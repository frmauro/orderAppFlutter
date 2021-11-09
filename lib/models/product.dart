class Product {
  int id;
  String amount;
  String description;
  String status;
  String price;

  Product(
      {required this.id,
      required this.amount,
      required this.description,
      required this.status,
      required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        amount: json["amount"].toString(),
        description: json["description"],
        status: json["status"],
        price: json["price"]);
  }
}
