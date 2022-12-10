import 'dart:io';
import 'package:julia/const/const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/package_details_model.dart';

Future<List<Package>> getpackageDetails() async {
  final response = await http.get(
    Uri.parse('$baseUrl/user/my/packege/63861781ebba82ae5eb2306b'),
    headers: {HttpHeaders.contentTypeHeader: "application/json"},
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    List res = json.decode(response.body);
    print(res);
    return res.map((e) => Package.fromJson(e)).toList();
  } else {
    throw Exception('Getting error while fetching data');
  }
}
