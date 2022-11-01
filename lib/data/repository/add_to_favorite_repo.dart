import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';

//function to add to wishlist
Future<bool> addtoFavorite(String userId, String productId) async {
  final response = await http
      .get(Uri.parse('$baseUrl/user/add/to/wishlist/$userId/$productId'));

  if (response.statusCode == 200) {
    var jsonRes = json.decode(response.body);
    print(jsonRes);
    return true;
  } else {
    return false;
    // throw Exception('getting error');
  }
}

//function to remove from wishlist
Future removefromFavorite(String userId, String productId) async {
  final response = await http
      .get(Uri.parse('$baseUrl/user/remove/from/wishlist/$userId/$productId'));

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return true;
  } else {
    throw Exception('getting error');
  }
}
