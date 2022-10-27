import 'package:julia/data/model/plans_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';

Future<List<Plans>> getallPlans() async {
  final response = await http.get(Uri.parse('$baseUrl/user/all/plans'));
  if (response.statusCode == 200) {
    List jsonRes = json.decode(response.body);
    return jsonRes.map((e) => Plans.fromJson(e)).toList();
  } else {
    throw Exception('Could not able to get data');
  }
}
