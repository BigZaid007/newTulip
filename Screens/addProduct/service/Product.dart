import 'dart:io';
import 'package:http/http.dart' as http;

class Product {
  final double productsPrice;
  final int productsDiscount;
  final bool isShow;
  final bool isDiscount;
  final String productsName;
  final int shopId;
  final List<File> fileChoose;
  final int categoriesId;
  final String productsDetails;
  final int productsId;

  Product({
    required this.productsPrice,
    required this.productsDiscount,
    required this.isShow,
    required this.isDiscount,
    required this.productsName,
    required this.shopId,
    required this.fileChoose,
    required this.categoriesId,
    required this.productsDetails,
    required this.productsId,
  });

  Map<String, String> toJson() => {
    'ProductsPrice': productsPrice.toString(),
    'ProductsDiscount': productsDiscount.toString(),
    'IsShow': isShow.toString(),
    'IsDiscount': isDiscount.toString(),
    'ProductsName': productsName,
    'ShopId': shopId.toString(),
    'CategoriesId': categoriesId.toString(),
    'ProductsDetails': productsDetails,
    'ProductsId': productsId.toString(),
  };
}

Future<void> addProduct(Product product) async {
  final url = Uri.parse('https://www.tulipm.net/api/Products');

  final request = http.MultipartRequest('POST', url)
    ..fields.addAll(product.toJson());

  for (var file in product.fileChoose) {
    request.files.add(await http.MultipartFile.fromPath('FileChoose', file.path));
  }

  final response = await http.Response.fromStream(await request.send());

  if (response.statusCode == 200) {
    print('product added');
  } else {
    // Handle error
  }
}

