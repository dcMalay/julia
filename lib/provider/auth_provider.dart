import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://52.67.149.51:3000';

class AuthProvider with ChangeNotifier {
  bool loading = false;
  getPostData(email) async {
    loading = true;
    await sendEmail(email);
    loading = false;
    notifyListeners();
  }
}

Future<http.Response> sendEmail(String email) async {
  return http.post(
    Uri.parse("$baseUrl/user/getprofile/email/$email"),
    headers: {HttpHeaders.contentTypeHeader: "application/json"},
  );
}
