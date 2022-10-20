import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';
import 'package:julia/data/model/dynamic_form_model.dart';

Future<List<DynamicForm>> getDynamicForm(String subCategoryId) async {
  final response = await http
      .get(Uri.parse('$baseUrl/user/app/extra/field/6332ddd73488c5687a3b38ed'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    List<DynamicForm> formData =
        jsonResponse.map((e) => DynamicForm.fromJson(e)).toList();
    return formData;
  } else {
    throw Exception('could get the data!');
  }
}
