import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:julia/const/const.dart';
import 'package:http/http.dart' as http;

const _secureStorage = FlutterSecureStorage();

Future getadStatus(String postId) async {
  var authToken = await _secureStorage.read(key: 'token');
  var authUser = await _secureStorage.read(key: 'userId');
  final response = await http.post(
    Uri.parse('$baseUrl/user/mark/sold'),
    headers: {
      HttpHeaders.authorizationHeader: authToken!,
      HttpHeaders.contentTypeHeader: "application/json"
    },
    body: json.encode(
      {
        "post_id": postId,
        "user_id": authUser,
      },
    ),
  );

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print("error");
  }
}

Future changeAdStatus(String postId) async {
  var authToken = await _secureStorage.read(key: 'token');
  var authUser = await _secureStorage.read(key: 'userId');
  final response = await http.post(
    Uri.parse('$baseUrl/user/re/post'),
    headers: {
      HttpHeaders.authorizationHeader: authToken!,
      HttpHeaders.contentTypeHeader: "application/json"
    },
    body: json.encode(
      {
        "post_id": postId,
        "user_id": authUser,
      },
    ),
  );

  if (response.statusCode == 200) {
    print('success');
    print(response.body);
  } else {
    print("error");
  }
}
