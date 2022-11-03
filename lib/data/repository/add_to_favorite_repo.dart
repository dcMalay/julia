import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';
import 'package:julia/data/model/wishlist_model.dart';

const _secureStorage = FlutterSecureStorage();
//function to add to wishlist

Future addtoFavorite(String productId) async {
  var authUser = await _secureStorage.read(key: 'userId');
  final response = await http
      .get(Uri.parse('$baseUrl/user/add/to/wishlist/$authUser/$productId'));
  print(authUser);
  print(productId);
  if (response.statusCode == 200) {
    var jsonRes = json.decode(response.body);
    print('Add to favorite ------>$jsonRes');
  } else {
    print('error--->${response.statusCode}');

    throw Exception('getting error');
  }
}

//function to remove from wishlist
Future removefromFavorite(String id) async {
  var authUser = await _secureStorage.read(key: 'userId');
  final response = await http
      .get(Uri.parse('$baseUrl/user/remove/from/wishlist/$authUser/$id'));

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    print('remove from favorite------->$jsonResponse');
    return true;
  } else {
    print('error--->${response.statusCode}');
    throw Exception('getting error');
  }
}

//getting wishlist products

Future<List<WishList>> getWishListProducts() async {
  var authUser = await _secureStorage.read(key: 'userId');
  var response =
      await http.get(Uri.parse('$baseUrl/user/my/wishlist/$authUser'));

  if (response.statusCode == 200) {
    List jsonRes = json.decode(response.body);
    var data = jsonRes.map((e) => WishList.fromJson(e)).toList();
    return data;
  } else {
    throw Exception('getting error');
  }
}

Future<List<WishList>> isInWishlist(String productId) async {
  var authUser = await _secureStorage.read(key: 'userId');
  print('Product id from fv------>$productId');
  final response = await http
      .get(Uri.parse('$baseUrl/user/is/in/wishlist/$authUser/$productId'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => WishList.fromJson(e)).toList();
  } else {
    throw Exception('Error occured');
  }
}
