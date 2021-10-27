class User {
  String id;
  String name;
  String email;
  String password;
  String userType;
  String status;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.userType,
      required this.status});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        userType: json["userType"],
        status: json["status"]);
  }
}
