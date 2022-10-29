import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';
import 'package:julia/data/model/all_boost_model.dart';

Future<List<AllBoost>> getallboost() async {
  final response = await http.get(Uri.parse('$baseUrl/user/all/boost/plans'));
  if (response.statusCode == 200) {
    List jsonRespone = json.decode(response.body);
    return jsonRespone.map((e) => AllBoost.fromJson(e)).toList();
  } else {
    throw Exception('getting error');
  }
}

Future<List<AllBoost>> getparticularboost(String subCategoryId) async {
  final response =
      await http.get(Uri.parse('$baseUrl/user/all/boost/plans/$subCategoryId'));
  if (response.statusCode == 200) {
    List jsonRespone = json.decode(response.body);
    return jsonRespone.map((e) => AllBoost.fromJson(e)).toList();
  } else {
    throw Exception('getting error');
  }
}
