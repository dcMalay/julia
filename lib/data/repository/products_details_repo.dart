import 'dart:convert';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/product_details_model.dart';
import 'package:http/http.dart' as http;

Future<List<ProductDetails>> getProductDetails(String productId) async {
  final response = await http.get(Uri.parse("$baseUrl/user/ads/$productId"));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => ProductDetails.fromJson(e)).toList();
  } else {
    throw Exception('could not able to get product details');
  }
}
