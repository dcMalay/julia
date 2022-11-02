import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/get_all_messages_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const _secureStorage = FlutterSecureStorage();

Future<List<Allmessage>> getallMessages() async {
  final response = await http.get(Uri.parse(
      '$baseUrl/user/getallmessage/6357b4a7e7a43f3066b007b7/63551a04e596901482a5c191'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => Allmessage.fromJson(e)).toList();
  } else {
    throw Exception('No data found');
  }
}

Future sendMessages(String receiverId, String senderId, String message) async {
  var authToken = await _secureStorage.read(key: 'token');
  var authUser = await _secureStorage.read(key: 'userId');
  final response = await http.post(
    Uri.parse('$baseUrl/user/sendmessage/$receiverId'),
    headers: {
      HttpHeaders.authorizationHeader: authToken!,
      HttpHeaders.contentTypeHeader: "application/json"
    },
    body: json.encode(
      {
        "reciver_id": receiverId,
        "sender_id": authUser,
        "message": message,
      },
    ),
  );

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print('Error');
  }
}
