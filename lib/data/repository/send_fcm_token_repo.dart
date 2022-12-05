import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';

const _secureStorage = FlutterSecureStorage();

Future sendFcmToken(String token) async {
  var authUser = await _secureStorage.read(key: 'userId');
  var authToken = await _secureStorage.read(key: 'token');
  final res = await http.get(
    Uri.parse('$baseUrl/subscribe/$authUser/$token'),
    headers: {
      HttpHeaders.authorizationHeader: authToken!,
      HttpHeaders.contentTypeHeader: "application/json"
    },
  );

  if (res.statusCode == 200) {
    print(res.body);
  } else {
    print('fcm token status ---->>${res.statusCode}');
  }
}
