import 'dart:io';
import 'package:http/http.dart' as http;

class Shop {
  String shopName;
  bool isActive;
  int? countryId;
  int id;
  double? longitude;
  double? latitude;
  String description;
  File? backgroundFile;
  File? logoFile;
  int shopCategories;

  Shop({
    required this.shopName,
    required this.isActive,
    this.countryId,
    required this.id,
    this.longitude,
    this.latitude,
    required this.description,
    this.backgroundFile,
    this.logoFile,
    required this.shopCategories,
  });

  Map<String, dynamic> toMap() {
    return {
      'ShopName': shopName,
      'shopCategories': shopCategories,
      'CountryId': countryId,
      if (id != null) 'Id': id,
      if (longitude != null) 'Long': longitude,
      if (latitude != null) 'Lat': latitude,
      if (description != null) 'Description': description,
      'IsActive': isActive,
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

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      isActive: json['isActive'],
      countryId: json['countryId'],
      id: json['id'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      description: json['description'],
      shopName: json['shopName'],
      backgroundFile: json['backgroundFile'],
      logoFile: json['logoFile'],
      shopCategories: json['shopCategories'],
    );
  }
}





class ShopOpeningHoursModel {
  String mondayOpeningTime;
  String mondayClosingTime;
  String tuesdayOpeningTime;
  String tuesdayClosingTime;
  String wednesdayOpeningTime;
  String wednesdayClosingTime;
  String thursdayOpeningTime;
  String thursdayClosingTime;
  String fridayOpeningTime;
  String fridayClosingTime;
  String saturdayOpeningTime;
  String saturdayClosingTime;
  String sundayOpeningTime;
  String sundayClosingTime;

  ShopOpeningHoursModel({
    required this.mondayOpeningTime,
    required this.mondayClosingTime,
    required this.tuesdayOpeningTime,
    required this.tuesdayClosingTime,
    required this.wednesdayOpeningTime,
    required this.wednesdayClosingTime,
    required this.thursdayOpeningTime,
    required this.thursdayClosingTime,
    required this.fridayOpeningTime,
    required this.fridayClosingTime,
    required this.saturdayOpeningTime,
    required this.saturdayClosingTime,
    required this.sundayOpeningTime,
    required this.sundayClosingTime,
  });
}
