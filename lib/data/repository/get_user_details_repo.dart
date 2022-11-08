import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:julia/const/const.dart';
import 'package:http/http.dart' as http;
import 'package:julia/data/model/profile_details_model.dart';

final _secureStorage = FlutterSecureStorage();

Future<Userdetails> getUserDetails() async {
  var authUser = await _secureStorage.read(key: "userId");
  var authToken = await _secureStorage.read(key: 'token');
  var url = '$baseUrl/user/get/my/profile/$authUser';

  final response = await http.post(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: authToken!,
    HttpHeaders.contentTypeHeader: "application/json"
  });
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return Userdetails.fromJson(jsonResponse);
  } else {
    throw Exception('Could not able to get user data');
  }
}

Future<Userdetails> getSellerDetails(String userId) async {
  var url = '$baseUrl/user/get/profile/$userId';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return Userdetails.fromJson(jsonResponse);
  } else {
    throw Exception('Could not able to get user data');
  }
}
