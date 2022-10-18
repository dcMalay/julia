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
//function to send otp to the email
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

//function to verify otp
  verifyOtp(String email, String otp) async {
    _loading = true;
    try {
      await verifyEmailOtp(otp, email);
      _loading = false;
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

//logout  function
  logout() async {
    _loading = true;
    try {
      logoutUser();
      userLogout();
      _loading = false;
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
