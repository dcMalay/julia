import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';
import '../model/seller_data_model.dart';

Future<SellerDataModel> getSellerdata(String sellerId) async {
  final response =
      await http.get(Uri.parse('$baseUrl/user/get/profile/$sellerId'));
  if (response.statusCode == 200) {
    var jsonRes = json.decode(response.body);
    return SellerDataModel.fromJson(jsonRes);
  } else {
    throw Exception('getting error');
  }
}
