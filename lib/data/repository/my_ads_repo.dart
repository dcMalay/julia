import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';
import 'package:julia/data/model/my_ads_model.dart';

const _secureStorage = FlutterSecureStorage();

Future<List<Myads>> getAdsData() async {
  List<Myads> adsData = [];

  var authToken = await _secureStorage.read(key: 'token');
  var authUser = await _secureStorage.read(key: 'userId');
  print('userid------->$authUser');
  print('token-------->$authToken');
  final response = await http.get(
    Uri.parse('$baseUrl/user/getMyads/$authUser'),
    headers: {
      HttpHeaders.authorizationHeader: authToken!,
      HttpHeaders.contentTypeHeader: "application/json"
    },
  );

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    for (var element in jsonResponse) {
      Myads model = Myads.fromJson(element);
      adsData.add(model);
    }
    // return jsonResponse.map((e) => Myads.fromJson(e)).toList();
    return adsData;
  } else {
    return throw Exception('Could not able to get categories');
  }
}
