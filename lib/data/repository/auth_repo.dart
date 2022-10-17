import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';
import 'package:julia/data/model/login_model.dart';

Future<Email> login(String email) async {
  final response = await http.get(
    Uri.parse("$baseUrl/user/getprofile/email/$email"),
  );
  final jsonResponse = Email.fromJson(json.decode(response.body));

  return jsonResponse;
}
