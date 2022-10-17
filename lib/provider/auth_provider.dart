import 'package:flutter/cupertino.dart';
import 'package:julia/data/repository/auth_repo.dart';

class AuthProvider with ChangeNotifier {
  bool _loading = false;
  bool isBack = false;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get loading => _loading;

  void sentEmail(email) async {
    _loading = true;
    try {
      await login(email);
      _loading = false;
      isBack = true;
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
