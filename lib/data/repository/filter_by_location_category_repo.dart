import 'package:julia/const/const.dart';
import 'package:julia/data/model/product_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Product>> filterbylocation(
    String locationId, String categoryId) async {
  final response = await http.post(
      Uri.parse('$baseUrl/user/ads/filterbylocation/category/0'),
      body: {"location": locationId, "category": categoryId});
  print(' lo -->$locationId co--->$categoryId');

  print(response.statusCode);
  print(response.body);

  if (response.statusCode == 200) {
    List jsonRes = json.decode(response.body);
    print('-------->>>>$jsonRes');
    return jsonRes.map((e) => Product.fromJson(e)).toList();
  } else {
    throw Exception();
  }
}
