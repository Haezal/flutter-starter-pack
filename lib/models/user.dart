class User {
  String userId;
  String name;
  String email;
  String token;

  User({this.userId, this.name, this.email, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      token: json['token'],
    );
  }
}
