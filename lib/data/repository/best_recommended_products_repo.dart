import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';
import 'package:julia/data/model/product_model.dart';

Future<List<Product>> getProduct() async {
  final res = await http.get(Uri.parse('$baseUrl/user/all/ads/0'));
  if (res.statusCode == 200) {
    List jsonResponse = json.decode(res.body);
    return jsonResponse.map((e) => Product.fromJson(e)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
