import 'package:julia/data/model/dynamic_city_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';

Future<List<City>> getcity(String locationId) async {
  final response =
      await http.get(Uri.parse('$baseUrl/user/all/city/$locationId'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => City.fromJson(e)).toList();
  } else {
    throw Exception('Getting Error');
  }
}
