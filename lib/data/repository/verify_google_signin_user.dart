import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/verify_otp_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';

const _secureStorage = FlutterSecureStorage();
Future<VerifyModel> gettokenforGlogin(String accessToken) async {
  final respone = await http.post(
    Uri.parse('$baseUrl/after/google/login'),
    headers: {HttpHeaders.contentTypeHeader: "application/json"},
    body: jsonEncode(
      {
        "access_token": accessToken,
      },
    ),
  );

  print('code ------->${respone.statusCode}');
  if (respone.statusCode == 200) {
    var jsonRes = json.decode(respone.body);
    var data = VerifyModel.fromJson(jsonRes);
    await _secureStorage.write(key: 'token', value: data.token);
    await _secureStorage.write(key: 'userId', value: data.userId);
    print(data.token);
    print(data.userId);
    return data;
  } else {
    throw Exception('getting error');
  }
}
