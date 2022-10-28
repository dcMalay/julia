import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';
import 'package:julia/data/model/my_ads_model.dart';

const _secureStorage = FlutterSecureStorage();

Future<List<Myads>> getAdsData() async {
  var authToken = await _secureStorage.read(key: 'token');
  var authUser = await _secureStorage.read(key: 'userId');
  final response = await http.get(
    Uri.parse('$baseUrl/user/getMyads/$authUser'),
    headers: {
      HttpHeaders.authorizationHeader: authToken!,
      HttpHeaders.contentTypeHeader: "application/json"
    },
  );

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => Myads.fromJson(e)).toList();
  } else {
    return throw Exception('Could not able to get categories');
  }
}
