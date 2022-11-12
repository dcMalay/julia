import 'package:julia/data/model/city_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';

Future<List<String>> getcity(String locationId) async {
  List<String> citylist = [];
  final response =
      await http.get(Uri.parse('$baseUrl/user/all/city/$locationId'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    var data = jsonResponse.map((e) => City.fromJson(e)).toList();
    for (var i = 0; i < data.length; i++) {
      citylist.add(data[i].cityName);
    }
    return citylist;
  } else {
    throw Exception('Getting Error');
  }
}
