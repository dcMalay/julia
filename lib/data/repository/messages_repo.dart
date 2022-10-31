import 'package:julia/const/const.dart';
import 'package:julia/data/model/get_all_messages_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
