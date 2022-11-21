import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';

const _secureStorage = FlutterSecureStorage();

Future rateSeller(
  String postId,
  String review,
  String sellerId,
  String starRating,
) async {
  var authToken = await _secureStorage.read(key: 'token');
  var authUser = await _secureStorage.read(key: 'userId');
  var userName = await _secureStorage.read(key: 'userName');
  final response = await http.post(Uri.parse('$baseUrl/user/write/review'),
      headers: {
        HttpHeaders.authorizationHeader: authToken!,
        HttpHeaders.contentTypeHeader: "application/json"
      },
      body: jsonEncode(<String, dynamic>{
        "post_id": postId,
        "review": review,
        "seller_id": sellerId,
        "star_rating": starRating,
        "user_id": authUser,
        "user_name": userName,
      }));
  //print(response.body);
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print(' $starRating ');
    print(response.statusCode);
  }
}
