import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';
import 'package:julia/data/model/message_sender_model.dart';
import 'dart:io';

const _secureStorage = FlutterSecureStorage();

Future<List<MessageSender>> getmessageSender() async {
  var authUser = await _secureStorage.read(key: 'userId');
  var authToken = await _secureStorage.read(key: 'token');
  final response = await http.get(
    Uri.parse('$baseUrl/user/getsenderlist/$authUser'),
    headers: {
      HttpHeaders.authorizationHeader: authToken!,
      HttpHeaders.contentTypeHeader: "application/json"
    },
  );

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => MessageSender.fromJson(e)).toList();
  } else {
    throw Exception('getting error');
  }
}



// Future<List<dynamic>> getSenderList() async {
//   var authUser = await _secureStorage.read(key: 'userId');
//   List data = [];
//   final response =
//       await http.get(Uri.parse("$baseUrl/user/getsenderlist/$authUser"));

// //storing the data to the sharedpreferances
//   final prefs = await SharedPreferences.getInstance();
//   var senderData = jsonEncode(response.body);
//   prefs.setString('senderJsonData', senderData);

//   if (response.statusCode == 200) {
//     List<dynamic> jsonResponse = json.decode(response.body);
//     print('sender userid ---->$jsonResponse');
//     data = jsonResponse;
//     return data;
//   } else {
//     throw Exception('Error occured');
//   }
// }

// Future<void> getSenderJsonData() async {
//   final prefs = await SharedPreferences.getInstance();
//   var temp = prefs.getString('jsonData') ?? jsonEncode(messageSenderData);
//   print('Stored messagesender data------>$temp');
//   var data = jsonDecode(temp.toString());
//   print('location--->$data');
// }
