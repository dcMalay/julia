import 'package:flutter/material.dart';
import 'package:julia/data/model/all_category_model.dart';
import 'package:julia/data/repository/all_category_repo.dart';

class CategoryProvider with ChangeNotifier {
  late List<AllCategory> category;
  bool _loading = false;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get loading => _loading;

  getCategory(context) async {
    _loading = true;
    try {
      category = await getAllCategory();
      _loading = false;
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
