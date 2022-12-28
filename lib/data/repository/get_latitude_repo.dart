import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/get_location_model.dart';

Future<List<Geolocation>> getlocation(final String location) async {
  final response =
      await http.get(Uri.parse('https://geocode.maps.co/search?q=$location'));
  print(response.statusCode);
  print('location---->$location');
  if (response.statusCode == 200) {
    List jsonRes = json.decode(response.body);
    var data = jsonRes.map((e) => Geolocation.fromJson(e)).toList();
    return data;
  } else {
    throw Exception('getting error!');
  }
}
