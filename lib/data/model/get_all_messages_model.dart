// To parse this JSON data, do
//
//     final allmessage = allmessageFromJson(jsonString);

import 'dart:convert';

List<Allmessage> allmessageFromJson(String str) =>
    List<Allmessage>.from(json.decode(str).map((x) => Allmessage.fromJson(x)));

String allmessageToJson(List<Allmessage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Allmessage {
  Allmessage({
    required this.id,
    required this.senderId,
    required this.message,
    required this.reciverId,
    required this.time,
    required this.v,
  });

  String id;
  String senderId;
  String message;
  String reciverId;
  DateTime time;
  int v;

  factory Allmessage.fromJson(Map<String, dynamic> json) => Allmessage(
        id: json["_id"],
        senderId: json["sender_id"],
        message: json["message"],
        reciverId: json["reciver_id"],
        time: DateTime.parse(json["time"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sender_id": senderId,
        "message": message,
        "reciver_id": reciverId,
        "time": time.toIso8601String(),
        "__v": v,
      };
}
