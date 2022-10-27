import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';
import 'package:julia/data/model/login_model.dart';
import 'package:julia/data/model/verify_otp_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _secureStorage = FlutterSecureStorage();

Future<Email> login(String email) async {
  final response = await http.get(
    Uri.parse("$baseUrl/user/getprofile/email/$email"),
  );
  final jsonResponse = Email.fromJson(json.decode(response.body));

  return jsonResponse;
}

Future verifyEmailOtp(String otp, String email) async {
  final url = '$baseUrl/user/getprofile/email/$email/$otp';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    final userData = VerifyOtp.fromJson(jsonResponse);
    await _secureStorage.write(key: 'token', value: userData.token);
    await _secureStorage.write(key: 'userId', value: userData.userId);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLoggedIn", true);

    return userData;
  } else if (response.statusCode == 400) {
    return;
  } else {
    throw Exception('getting error while otp verification');
  }
}

void userLogout() async {
  await _secureStorage.delete(key: 'token');
  await _secureStorage.delete(key: 'userId');
  print("user log out!");
}

void logoutUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}
