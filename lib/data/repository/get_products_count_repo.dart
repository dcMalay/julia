import '../../const/const.dart';
import '../model/category_count_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<ProductsCountModel>> getProductsCount() async {
  final res = await http.get(Uri.parse('$baseUrl/user/count/post/by/category'));
  if (res.statusCode == 200) {
    List jsonRes = json.decode(res.body);
    return jsonRes.map((e) => ProductsCountModel.fromJson(e)).toList();
  } else {
    throw Exception('getting error');
  }
}

Future<List<ProductsCountModel>> getSubProductsCount() async {
  final res =
      await http.get(Uri.parse('$baseUrl/user/count/post/by/subcategory'));
  if (res.statusCode == 200) {
    List jsonRes = json.decode(res.body);
    return jsonRes.map((e) => ProductsCountModel.fromJson(e)).toList();
  } else {
    throw Exception('getting error');
  }
}
