import 'package:flutter/material.dart';
import 'package:julia/data/model/product_model.dart';
import 'package:julia/data/repository/filter_by_price_repo.dart';

class PriceFilterProvider with ChangeNotifier {
  late List<Product> filterbypriceProducts;

  getpricefilteredProducts(String categoryId, int minval, int maxval) async {
    try {
      filterbypriceProducts =
          await filterProcuctsByPrice(categoryId, minval, maxval);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
