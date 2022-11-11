import 'dart:ffi';

import 'package:julia/const/const.dart';
import 'package:julia/data/model/product_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Product>> filterProcuctsByPrice(
    String categoryId, double minval, double maxval) async {
  final response = await http
      .post(Uri.parse('$baseUrl/user/ads/filterbyprice/category/0'), body: {
    "location": "all",
    "category": categoryId,
    "minval": minval,
    "maxval": maxval,
  });
  print('$minval $maxval $categoryId');
  if (response.statusCode == 200) {
    List jsonRes = json.decode(response.body);
    return jsonRes.map((e) => Product.fromJson(e)).toList();
  } else {
    print(response.body);
    throw Exception();
  }
}
