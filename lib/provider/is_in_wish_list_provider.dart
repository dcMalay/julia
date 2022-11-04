import 'package:flutter/material.dart';
import 'package:julia/data/model/wishlist_model.dart';
import 'package:julia/data/repository/add_to_favorite_repo.dart';

class IsInWishListProvider extends ChangeNotifier {
  List<WishList> wishData = [];
  List wishedProductIds = [];
  void isInWishList() async {
    try {
      wishData = await getWishListProducts();
      for (var i = 0; i < wishData.length; i++) {
        wishedProductIds.add(wishData[i].wishProductId);
      }
      print('provider data ------>${wishedProductIds}');
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
