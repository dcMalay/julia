import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';
import 'package:julia/data/saved_json_data/stored_sender_data/message_sender_json_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _secureStorage = FlutterSecureStorage();

Future<List<String>> getSenderList() async {
  var authUser = await _secureStorage.read(key: 'userId');
  final response =
      await http.get(Uri.parse("$baseUrl/user/getsenderlist/$authUser"));

//storing the data to the sharedpreferances
  final prefs = await SharedPreferences.getInstance();
  var senderData = jsonEncode(response.body);
  prefs.setString('senderJsonData', senderData);

  if (response.statusCode == 200) {
    List<String> jsonResponse = json.decode(response.body);
    return jsonResponse;
  } else {
    throw Exception('Error occured');
  }
}

Future<void> getSenderJsonData() async {
  final prefs = await SharedPreferences.getInstance();
  var temp = prefs.getString('jsonData') ?? jsonEncode(messageSenderData);
  print('Stored messagesender data------>$temp');
  var data = jsonDecode(temp.toString());
  print('location--->$data');
}
