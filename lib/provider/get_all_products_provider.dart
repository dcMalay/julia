import 'package:flutter/material.dart';
import 'package:julia/data/repository/products_repo.dart';
import '../data/model/product_model.dart';

class AllProductProvider with ChangeNotifier {
  List<Product> list = [];
  late List<Product> productsList;

  getallProducts(String offset) async {
    try {
      productsList = await getProduct(offset);
      list.addAll(productsList);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
