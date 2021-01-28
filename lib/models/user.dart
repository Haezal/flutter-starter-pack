class User {
  String userId;
  String secureId;
  String name;
  String email;
  String token;
  String userType;

  User({this.userId, this.name, this.email, this.secureId, this.userType, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['staff_no'],
      secureId: json['secure_id'],
      name: json['name'],
      email: json['email'],
      token: json['token'],
      userType: json['user_type'],
    );
  }
}
