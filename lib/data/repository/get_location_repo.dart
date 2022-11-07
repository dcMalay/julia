import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';
import 'package:julia/data/saved_json_data/stored_location/location_json_data.dart';
import 'package:julia/data/model/location_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Location>> getLocation() async {
  final response = await http.get(Uri.parse('$baseUrl/user/all/location'));
//storing the data to the sharedpreferances
  final prefs = await SharedPreferences.getInstance();
  var saveData = jsonEncode(response.body);
  await prefs.setString('jsonData', saveData);
  print('location data----->$saveData');
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => Location.fromJson(e)).toList();
  } else {
    throw Exception('getting error');
  }
}

Future<void> getlocationJsonData() async {
  final prefs = await SharedPreferences.getInstance();
  var temp = prefs.getString('jsonData') ?? jsonEncode(defaultData);
  print('Data receied------>$temp');
  var data = Location.fromJson(jsonDecode(temp.toString()));
  print('location--->${data.locationName}');
  print('id ----->${data.id}');
}
