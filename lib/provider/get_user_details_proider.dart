import 'package:flutter/material.dart';
import 'package:julia/data/model/profile_details_model.dart';
import 'package:julia/data/repository/get_user_details_repo.dart';

class GetProfileDetailsProvider extends ChangeNotifier {
  late Userdetails getUserData;
  void getownprofiledata() async {
    try {
      getUserData = await getUserDetails();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
