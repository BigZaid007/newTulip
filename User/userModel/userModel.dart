class User {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String userName;
  final String password;
  final String logo;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.userName,
    required this.password,
    required this.logo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      userName: json['userName'],
      password: json['password'],
      logo: json['logo'],
    );
  }
}
