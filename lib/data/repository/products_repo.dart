import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';
import 'package:julia/data/model/product_model.dart';

Future<List<Product>> getProduct(String offset) async {
  final res = await http.get(Uri.parse('$baseUrl/user/all/ads/$offset'));
  if (res.statusCode == 200) {
    List jsonResponse = json.decode(res.body);
    return jsonResponse
        .map((dynamic item) => Product.fromJson(item))
        .fold<Map<String, Product>>({}, (map, element) {
          map.putIfAbsent(element.sId!, () => element);
          return map;
        })
        .values
        .toList();

    // return jsonResponse.map((e) => Product.fromJson(e)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
