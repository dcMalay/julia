import 'package:flutter/material.dart';
import 'package:julia/data/repository/add_to_favorite_repo.dart';

class AddToFavorite with ChangeNotifier {
  addtoFav(String productId) {
    try {
      addtoFavorite(productId);
    } catch (e) {
      print(e);
    }
  }

  removeFromFav(String id) {
    try {
      removefromFavorite(id);
    } catch (e) {
      print(e);
    }
  }
}
