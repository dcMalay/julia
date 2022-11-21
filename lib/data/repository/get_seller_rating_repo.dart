import '../model/reting_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';

Future<List<RatingModel>> getSellerRatingDetails(String sellerID) async {
  final response =
      await http.get(Uri.parse('$baseUrl/user/read/seller/review/$sellerID'));
  if (response.statusCode == 200) {
    List jsonRes = json.decode(response.body);
    var rating = jsonRes.map((e) => RatingModel.fromJson(e)).toList();
    return rating;
  } else {
    throw Exception('getting error');
  }
}
