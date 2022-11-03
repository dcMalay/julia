import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:julia/data/model/product_details_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';

const _secureStorage = FlutterSecureStorage();

Future<List<ProductDetails>> getNotification() async {
  var authUser = await _secureStorage.read(key: 'userId');
  final response =
      await http.get(Uri.parse('$baseUrl/user/get/notice/$authUser'));
  if (response.statusCode == 200) {
    List jsonRes = json.decode(response.body);
    return jsonRes.map((e) => ProductDetails.fromJson(e)).toList();
  } else {
    throw Exception('Getting error while fetching data');
  }
}
