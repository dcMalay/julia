import 'package:flutter/cupertino.dart';
import 'package:julia/data/model/category_count_model.dart';
import 'package:julia/data/repository/get_products_count_repo.dart';

class GetProductsCountProvider extends ChangeNotifier {
  List<ProductsCountModel> productsCount = [];
  late List<ProductsCountModel> subproductsCount;
  getnumberofProducts() async {
    try {
      productsCount = await getProductsCount();
      print('count id ----->${productsCount[0].id}');
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  getsubProducts() async {
    try {
      subproductsCount = await getProductsCount();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
