import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:julia/query/getproducts_model.dart';

const baseUrl = "http://localhost:3000";

Future<List<AllProduct>> getProduct() async {
  final res = await http.get(Uri.parse('$baseUrl/user/all/ads/0'));
  if (res.statusCode == 200) {
    var jsonResponse = json.decode(res.body);
    return jsonResponse
        .map((data) => AllProduct.fromJson(jsonResponse))
        .toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
