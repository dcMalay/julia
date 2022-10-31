import 'package:flutter/material.dart';
import 'package:julia/data/model/product_model.dart';

class ProductSearchProider extends ChangeNotifier {
  List<Product> dataList = [];

  Future<void> updateDataModel(List<Product> dataList) async {
    this.dataList = dataList;
    notifyListeners();
  }
}
