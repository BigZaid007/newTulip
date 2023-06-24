class RegisterAccountResponse {
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
  final String code;
  final bool isConfirmed;
  final String token;

  RegisterAccountResponse({
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
    required this.code,
    required this.isConfirmed,
    required this.token,
  });

  factory RegisterAccountResponse.fromJson(Map<String, dynamic> json) {
    return RegisterAccountResponse(
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
      code: json['code'],
      isConfirmed: json['isConfirm'],
      token: json['token'],
    );
  }
}
