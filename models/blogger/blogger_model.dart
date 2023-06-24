import 'dart:io';

class RegisterModelRequest {
  final int id;
  final int modelTypeId;
  final String? long;
  final String? lat;
  final bool isActive;
  // final int? countryId;
  final File fileChoose;
  final String Description;
  final String ModelName;

  RegisterModelRequest( {
    required this.id,
    required this.modelTypeId,
     this.long,
     this.lat,
    required this.isActive,
    // required this.countryId,
    required this.fileChoose,
    required this.Description,
    required  this.ModelName,

  });

  Map<String, dynamic> toFieldsMap() {
    return {
      'id':id,
      'ModelTypeId': modelTypeId,
      'Long': long,
      'Lat': lat,
      'IsActive': isActive,
      // 'CountryId': countryId,
      'FileChoose': fileChoose.path,
      'ModelName':ModelName,
      'Description':Description

    };
  }

  factory RegisterModelRequest.fromJson(Map<String, dynamic> json) {
    return RegisterModelRequest(
      id: json['Id'],
      modelTypeId: json['ModelTypeId'],
      long: json['Long'],
      lat: json['Lat'],
      isActive: json['IsActive'],
      // countryId: json['CountryId'],
      fileChoose: json['FileChoose'],
      ModelName:json['ModelName'],
      Description:json['Description']


    );
  }
}
