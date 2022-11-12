import 'package:flutter/material.dart';
import 'package:julia/data/model/product_model.dart';
import 'package:julia/data/repository/filter_by_location_category_repo.dart';

class LocationFilterProvider with ChangeNotifier {
  late List<Product> filterbylocationProducts;

  getfilteredProducts(String locationId, String categoryId) async {
    try {
      filterbylocationProducts = await filterbylocation(locationId, categoryId);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
