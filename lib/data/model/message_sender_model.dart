// To parse this JSON data, do
//
//     final messageSender = messageSenderFromJson(jsonString);

import 'dart:convert';

List<MessageSender> messageSenderFromJson(String str) =>
    List<MessageSender>.from(
        json.decode(str).map((x) => MessageSender.fromJson(x)));

String messageSenderToJson(List<MessageSender> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageSender {
  MessageSender({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAbout,
    required this.userImage,
    required this.v,
  });

  String id;
  String userId;
  String userName;
  String userAbout;
  String userImage;
  int v;

  factory MessageSender.fromJson(Map<String, dynamic> json) => MessageSender(
        id: json["_id"],
        userId: json["user_id"],
        userName: json["user_name"],
        userAbout: json["user_about"],
        userImage: json["user_image"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "user_name": userName,
        "user_about": userAbout,
        "user_image": userImage,
        "__v": v,
      };
}
