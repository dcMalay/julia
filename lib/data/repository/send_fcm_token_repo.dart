import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';

const _secureStorage = FlutterSecureStorage();

Future sendFcmToken(String token) async {
  var authUser = await _secureStorage.read(key: 'userId');
  final res = await http.get(Uri.parse('$baseUrl/subscriber/$authUser/$token'));

  if (res.statusCode == 200) {
    print(res.body);
  }else{
    print(res.statusCode);
  }
}
