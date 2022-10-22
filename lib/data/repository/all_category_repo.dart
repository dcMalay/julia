import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';
import 'package:julia/data/model/all_category_model.dart';

Future<List<AllCategory>> getAllCategory() async {
  final response = await http.get(Uri.parse('$baseUrl/user/all/category'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => AllCategory.fromJson(e)).toList();
  } else {
    return throw Exception('Could not able to get categories');
  }
}
