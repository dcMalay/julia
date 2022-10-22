import 'package:julia/const/const.dart';
import 'package:julia/data/model/sub_category_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<SubCategories>> getSubcategory(String categotyId) async {
  final response =
      await http.get(Uri.parse("$baseUrl/user/all/subcategory/$categotyId"));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => SubCategories.fromJson(e)).toList();
  } else {
    throw Exception('cound not get the subcategory');
  }
}
