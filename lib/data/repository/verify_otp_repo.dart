import 'dart:convert';
import 'package:julia/const/const.dart';
import 'package:http/http.dart' as http;
import 'package:julia/data/model/verify_otp_model.dart';

Future<VerifyOtp> verifyEmailOtp(String otp, String email) async {
  final url = '$baseUrl/user/getprofile/email/$email/$otp';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print("response---------->$jsonResponse");
    return VerifyOtp.fromJson(jsonResponse);
  } else {
    throw Exception('getting error while otp verification');
  }
}
