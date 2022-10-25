// To parse this JSON data, do
//
//     final userdetails = userdetailsFromJson(jsonString);

import 'dart:convert';

Userdetails userdetailsFromJson(String str) =>
    Userdetails.fromJson(json.decode(str));

String userdetailsToJson(Userdetails data) => json.encode(data.toJson());

class Userdetails {
  Userdetails({
    required this.data,
    required this.user,
  });

  List<Datum> data;
  List<User> user;

  factory Userdetails.fromJson(Map<String, dynamic> json) => Userdetails(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "user": List<dynamic>.from(user.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAbout,
    required this.userImage,
    required this.userCity,
    required this.userAddress1,
    required this.v,
  });

  String id;
  String userId;
  String userName;
  String userAbout;
  String userImage;
  String userCity;
  String userAddress1;
  int v;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        userId: json["user_id"],
        userName: json["user_name"],
        userAbout: json["user_about"],
        userImage: json["user_image"],
        userCity: json["user_city"],
        userAddress1: json["user_address1"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "user_name": userName,
        "user_about": userAbout,
        "user_image": userImage,
        "user_city": userCity,
        "user_address1": userAddress1,
        "__v": v,
      };
}

class User {
  User({
    required this.id,
    required this.userEmail,
    required this.password,
    required this.userStatus,
    required this.postAvailable,
    required this.v,
    required this.userPhone,
  });

  String id;
  String userEmail;
  String password;
  int userStatus;
  int postAvailable;
  int v;
  String userPhone;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        userEmail: json["user_email"],
        password: json["password"],
        userStatus: json["user_status"],
        postAvailable: json["post_available"],
        v: json["__v"],
        userPhone: json["user_phone"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_email": userEmail,
        "password": password,
        "user_status": userStatus,
        "post_available": postAvailable,
        "__v": v,
        "user_phone": userPhone,
      };
}
