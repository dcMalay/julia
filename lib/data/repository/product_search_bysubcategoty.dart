import 'package:julia/const/const.dart';
import 'package:julia/data/model/product_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Product>> getproductBySubcategory(String subcategoryId) async {
  final response = await http
      .get(Uri.parse("$baseUrl/user/ads/bysubcategory/$subcategoryId/0"));

  if (response.statusCode == 200) {
    List jsonRes = json.decode(response.body);
    return jsonRes.map((e) => Product.fromJson(e)).toList();
  } else {
    throw Exception('This sub category does not have any data ');
  }
}
