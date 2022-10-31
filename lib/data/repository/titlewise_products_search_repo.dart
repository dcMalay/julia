import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';
import 'package:julia/data/model/product_model.dart';

Future<List<Product>> getSearchedProduct(String productTitle) async {
  List<Product> productList = [];
  final res = await http
      .get(Uri.parse('$baseUrl/user/search/product/title/$productTitle'));
  if (res.statusCode == 200) {
    List jsonResponse = json.decode(res.body);
    for (var e in jsonResponse) {
      Product model = Product.fromJson(e);
      productList.add(model);
    }
    return productList;
    //return jsonResponse.map((e) => Product.fromJson(e)).toList();
  } else {
    throw Exception('search bar is empty');
  }
}
