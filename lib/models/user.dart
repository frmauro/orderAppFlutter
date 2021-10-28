class User {
  String id;
  String name;
  String email;
  String password;
  String userType;
  String token;
  String status;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.userType,
      required this.token,
      required this.status});

  //[{"_id":"611aa80245c2ed2212c3ec3d","name":"Francisco Mauro","email":"frmauro8@gmail.com","password":"123","status":"active","token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXNzd29yZCI6IjEyMyIsImlhdCI6MTYzNTQ0MzExNCwiZXhwIjoxNjM1NDQ2NzE0fQ.GHYqR-usxhuBU-i2Pem4iXMCP2H8L3HkiiGzRJtNIB8","userType":"administrator","__v":0}]

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        status: json["status"],
        token: json["token"],
        userType: json["userType"]);
  }
}
