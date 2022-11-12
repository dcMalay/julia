// To parse this JSON data, do
//
//     final wishListProduct = wishListProductFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

WishListProduct wishListProductFromJson(String str) =>
    WishListProduct.fromJson(json.decode(str));

String wishListProductToJson(WishListProduct data) =>
    json.encode(data.toJson());

class WishListProduct {
  WishListProduct({
    required this.wishlist,
    required this.products,
  });

  List<Wishlist> wishlist;
  List<Product> products;

  factory WishListProduct.fromJson(Map<String, dynamic> json) =>
      WishListProduct(
        wishlist: List<Wishlist>.from(
            json["wishlist"].map((x) => Wishlist.fromJson(x))),
        products: List<Product>.from(json["products"]
            .map((x) => x == null ? null : Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "wishlist": List<dynamic>.from(wishlist.map((x) => x.toJson())),
        "products": List<dynamic>.from(
            products.map((x) => x == null ? null : x.toJson())),
      };
}

class Product {
  Product({
    required this.id,
    required this.postCategory,
    required this.postSubcategory,
    required this.postStatus,
    required this.postUserId,
    required this.postFeatured,
    required this.postLocation,
    required this.postCity,
    required this.fields,
    required this.postTitle,
    required this.postImage,
    required this.postSold,
    required this.postPrice,
    required this.postDescription,
    required this.authName,
    required this.postDate,
    required this.v,
  });

  String id;
  String postCategory;
  String postSubcategory;
  String postStatus;
  String postUserId;
  int postFeatured;
  String postLocation;
  String postCity;
  String fields;
  String postTitle;
  List<String> postImage;
  String postSold;
  num postPrice;
  String postDescription;
  String authName;
  DateTime postDate;
  int v;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        postCategory: json["post_category"],
        postSubcategory: json["post_subcategory"],
        postStatus: json["post_status"],
        postUserId: json["post_user_id"],
        postFeatured: json["post_featured"],
        postLocation: json["post_location"],
        postCity: json["post_city"],
        fields: json["fields"],
        postTitle: json["post_title"],
        postImage: List<String>.from(json["post_image"].map((x) => x)),
        postSold: json["post_sold"],
        postPrice: json["post_price"],
        postDescription: json["post_description"],
        authName: json["auth_name"],
        postDate: DateTime.parse(json["post_date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "post_category": postCategory,
        "post_subcategory": postSubcategory,
        "post_status": postStatus,
        "post_user_id": postUserId,
        "post_featured": postFeatured,
        "post_location": postLocation,
        "post_city": postCity,
        "fields": fields,
        "post_title": postTitle,
        "post_image": List<dynamic>.from(postImage.map((x) => x)),
        "post_sold": postSold,
        "post_price": postPrice,
        "post_description": postDescription,
        "auth_name": authName,
        "post_date": postDate.toIso8601String(),
        "__v": v,
      };
}

class Wishlist {
  Wishlist({
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

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
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
