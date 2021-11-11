class Product {
  int id;
  String amount;
  String description;
  String status;
  String price;
  int quatity;

  Product(
      {required this.id,
      required this.amount,
      required this.description,
      required this.status,
      required this.price,
      required this.quatity});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        amount: json["amount"].toString(),
        description: json["description"],
        status: json["status"],
        price: json["price"],
        quatity: 0);
  }

  Map toJson() => {
        'amount': amount,
        'description': description,
        'status': status,
        'price': price,
        'quantity': quatity
      };
}
