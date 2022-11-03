// To parse this JSON data, do
//
//     final wishList = wishListFromJson(jsonString);

import 'dart:convert';

List<WishList> wishListFromJson(String str) =>
    List<WishList>.from(json.decode(str).map((x) => WishList.fromJson(x)));

String wishListToJson(List<WishList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WishList {
  WishList({
    required this.id,
    required this.wishUserId,
    required this.wishProductId,
    required this.wishDate,
    required this.v,
  });

  String id;
  String wishUserId;
  String wishProductId;
  DateTime wishDate;
  int v;

  factory WishList.fromJson(Map<String, dynamic> json) => WishList(
        id: json["_id"],
        wishUserId: json["wish_user_id"],
        wishProductId: json["wish_product_id"],
        wishDate: DateTime.parse(json["wish_date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "wish_user_id": wishUserId,
        "wish_product_id": wishProductId,
        "wish_date": wishDate.toIso8601String(),
        "__v": v,
      };
}
