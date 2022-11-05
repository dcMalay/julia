import 'package:flutter/material.dart';
import 'package:julia/data/model/product_details_model.dart';
import 'package:julia/data/repository/products_details_repo.dart';

class ProducrDetailsProvider extends ChangeNotifier {
  List<ProductDetails> productDetails = [];
  void pDetais(String productId) async {
    try {
      productDetails = await getProductDetails(productId);
    } catch (e) {
      print('error ------>$e');
    }
    notifyListeners();
  }
}
