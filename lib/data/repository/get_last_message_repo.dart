import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:julia/const/const.dart';
import '../model/last_message_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const _secureStorage = FlutterSecureStorage();

Future<List<Lastmessage>> getlastmessage() async {
  var authUser = await _secureStorage.read(key: 'userId');
  final response =
      await http.get(Uri.parse('$baseUrl/user/getmessage/$authUser'));

  if (response.statusCode == 200) {
    List res = json.decode(response.body);
    var messagedata = res.map((e) => Lastmessage.fromJson(e)).toList();
    return messagedata;
  } else {
    throw Exception('getting error');
  }
}
