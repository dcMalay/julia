import 'dart:io';

import 'package:julia/const/const.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

const _secureStorage = FlutterSecureStorage();

void createTicket(String message) async {
  var authUser = await _secureStorage.read(key: 'userId');
  var authToken = await _secureStorage.read(key: 'token');
  final res = await http.post(Uri.parse('$baseUrl/user/create/ticket'),
      headers: {
        HttpHeaders.authorizationHeader: authToken!,
        HttpHeaders.contentTypeHeader: "application/json"
      },
      body: jsonEncode({"user_id": authUser, "message": message}));

  if (res.statusCode == 200) {
    print(res.body);
  } else {
    print(res.statusCode);
  }
}
