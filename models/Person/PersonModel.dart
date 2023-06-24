class Person {
  final int id;
  final String? centerName;
  final String? logo;
  final int personTypeId;
  final String phone;
  final String name;
  final String userName;


  Person({
    required this.id,
    this.centerName,
    this.logo,

    required this.personTypeId,
    required this.phone,
    required this.name,
    required this.userName,

  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      centerName: json['centerName'],
      logo: json['logo'],

      personTypeId: json['personTypeId'],
      phone: json['phone'],
      name: json['name'],
      userName: json['userName'],

    );
  }
}
