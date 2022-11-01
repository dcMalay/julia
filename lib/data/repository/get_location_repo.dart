import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';
import 'package:julia/data/model/location_model.dart';

Future<List<Location>> getallLocation() async {
  final response = await http.get(Uri.parse('$baseUrl/user/all/location'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => Location.fromJson(e)).toList();
  } else {
    throw Exception('getting error');
  }
}
