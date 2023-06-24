class LoginData {
  final int id;
  final int personTypeId;
  final String phone;
  final String email;
  final String name;
  final String userName;
  final String password;
  final double longitude;
  final double latitude;
  final bool isActive;
  final int countryId;
  final String code;
  final bool isConfirm;
  final String token;

  LoginData({
    required this.id,
    required this.personTypeId,
    required this.phone,
    required this.email,
    required this.name,
    required this.userName,
    required this.password,
    required this.longitude,
    required this.latitude,
    required this.isActive,
    required this.countryId,
    required this.code,
    required this.isConfirm,
    required this.token,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      id: json['id'],
      personTypeId: json['personTypeId'],
      phone: json['phone'],
      email: json['email'],
      name: json['name'],
      userName: json['userName'],
      password: json['password'],
      longitude: json['long'],
      latitude: json['lat'],
      isActive: json['isActive'],
      countryId: json['countryId'],
      code: json['code'],
      isConfirm: json['isConfirm'],
      token: json['token'],
    );
  }
}