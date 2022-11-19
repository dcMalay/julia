import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../const/const.dart';

Dio dio = Dio();
final _secureStorage = FlutterSecureStorage();
List imageNames = [];

Future postProducts(
  data,
  categoryId,
  subCategoryId,
  _dropDownValue,
  city,
  title,
  price,
  desc,
  username,
) {
  return
//using dio to post imagename to the mongodg api and the name we get from the php server
      dio.post("https://julia.sr/upload.php", data: data).then((response) {
    imageNames.add(response.data);
    print('image list -------->$imageNames');
    postProductData(
      imageNames,
      categoryId,
      subCategoryId,
      _dropDownValue,
      city,
      title,
      price,
      desc,
      username,
    );
  }).catchError((error) => print(error));
}

void postProductData(
  imageName,
  categoryId,
  subCategoryId,
  _dropDownValue,
  city,
  title,
  price,
  desc,
  username,
) async {
  var authToken = await _secureStorage.read(key: 'token');
  var authUser = await _secureStorage.read(key: 'userId');
  var response = await http.post(Uri.parse('$baseUrl/user/create/new/ad'),
      headers: {
        HttpHeaders.authorizationHeader: authToken!,
        HttpHeaders.contentTypeHeader: "application/json"
      },
      body: jsonEncode(<String, dynamic>{
        "post_category": categoryId,
        "post_subcategory": subCategoryId,
        "post_user_id": authUser,
        "fields": '{}',
        "location": _dropDownValue,
        'city': city,
        "post_title": title,
        "post_image": json.encode(imageName),
        "post_price": price,
        "post_description": desc,
        "auth_name": username,
      }));
  print('json encoded data------>${json.encode(imageName)}');
  if (response.statusCode == 200) {
    print('status code 200 is ---->${response.body}');
  } else {
    print('getting error ------>${response.body}');
  }
}
