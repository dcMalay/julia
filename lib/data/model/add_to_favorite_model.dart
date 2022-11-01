// To parse this JSON data, do
//
//     final addtoFavorite = addtoFavoriteFromJson(jsonString);

import 'dart:convert';

AddtoFavorite addtoFavoriteFromJson(String str) =>
    AddtoFavorite.fromJson(json.decode(str));

String addtoFavoriteToJson(AddtoFavorite data) => json.encode(data.toJson());

class AddtoFavorite {
  AddtoFavorite({
    required this.wishUserId,
    required this.wishProductId,
    required this.id,
    required this.wishDate,
    required this.v,
  });

  String wishUserId;
  String wishProductId;
  String id;
  DateTime wishDate;
  int v;

  factory AddtoFavorite.fromJson(Map<String, dynamic> json) => AddtoFavorite(
        wishUserId: json["wish_user_id"],
        wishProductId: json["wish_product_id"],
        id: json["_id"],
        wishDate: DateTime.parse(json["wish_date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "wish_user_id": wishUserId,
        "wish_product_id": wishProductId,
        "_id": id,
        "wish_date": wishDate.toIso8601String(),
        "__v": v,
      };
}
