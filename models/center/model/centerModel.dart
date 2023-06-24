import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class centerModel {
  String centerName;
  File? backgroundFile;
  int? sectionsId;
  int countryId;
  int id;
  double? longitude;
  double? latitude;
  String description;
  File? logoFile;
  List service;

  centerModel({
    required this.centerName,
     this.backgroundFile,
    this.sectionsId,
    required this.countryId,
    required this.id,
    this.longitude,
    this.latitude,
    required this.description,
     this.logoFile,
    required this.service
  });

  Map<String, dynamic> toMap() {
    return {
      'CenterName': centerName,
      'SectionsId': sectionsId,
      'CountryId': countryId,
      'ServicesName':service,
      if (id != null) 'Id': id,
      if (longitude != null) 'Long': longitude,
      if (latitude != null) 'Lat': latitude,
      if (description != null) 'Description': description,
    };
  }

  Future<Map<String, dynamic>> toMultipartMap() async {
    Map<String, dynamic> map = toMap();
    if (backgroundFile != null) {
      map['FileChooseBakground'] = await http.MultipartFile.fromPath(
        'FileChooseBakground',
        backgroundFile!.path,
      );
    }
    if (logoFile != null) {
      map['FileChooseLogo'] = await http.MultipartFile.fromPath(
        'FileChooseLogo',
        logoFile!.path,
      );
    }
    return map;
  }

  factory centerModel.fromJson(Map<String, dynamic> json) {
    return centerModel(
      sectionsId: json['sectionsId'],
      service: json['ServicesName'],
      centerName: json['centerName'],
      logoFile:  json['logo'],
      backgroundFile:  json['backgroundImage'],
      description: json['description'],
      countryId: json['countryId'],
      id: json['id']


    );
  }
}


