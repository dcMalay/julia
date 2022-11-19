class Lastmessage {
  Lastmessage({
    this.id,
    this.senderId,
    this.message,
    this.reciverId,
    this.time,
  });

  String? id;
  String? senderId;
  String? message;
  String? reciverId;
  DateTime? time;

  factory Lastmessage.fromJson(Map<String, dynamic> json) => Lastmessage(
        id: json["_id"],
        senderId: json["sender_id"],
        message: json["message"],
        reciverId: json["reciver_id"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sender_id": senderId,
        "message": message,
        "reciver_id": reciverId,
        "time": time!.toIso8601String(),
      };
}
