import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:julia/query/product_model.dart';

const baseUrl = "http://52.67.149.51:3000";

Future<List<Product>> getProduct() async {
  final res = await http.get(Uri.parse('$baseUrl/user/all/ads/0'));
  if (res.statusCode == 200) {
    List jsonResponse = json.decode(res.body);
    print(jsonResponse);
    return jsonResponse.map((e) => Product.fromJson(e)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
