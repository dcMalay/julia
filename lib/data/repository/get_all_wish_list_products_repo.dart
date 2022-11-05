import 'package:julia/data/model/wishlist_product_model.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';

const _secureStorage = FlutterSecureStorage();

Future<WishListProduct> getwishlistproducts() async {
  var authUser = await _secureStorage.read(key: 'userId');
  final response =
      await http.get(Uri.parse('$baseUrl/user/app/my/wishlist/$authUser'));
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    return WishListProduct.fromJson(jsonResponse);
  } else {
    throw Exception('getting error');
  }
}
