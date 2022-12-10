class Package {
  Package({
    this.id,
    this.planId,
    this.userId,
    this.postAvailable,
    this.endDate,
    this.postIds,
    this.txnId,
    this.purchaseDate,
    this.v,
  });

  String? id;
  List<String>? planId;
  String? userId;
  int? postAvailable;
  DateTime? endDate;
  List<String>? postIds;
  String? txnId;
  DateTime? purchaseDate;
  int? v;

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["_id"],
        planId: List<String>.from(json["plan_id"].map((x) => x)),
        userId: json["user_id"],
        postAvailable: json["post_available"],
        endDate: DateTime.parse(json["end_date"]),
        postIds: List<String>.from(json["post_ids"].map((x) => x)),
        txnId: json["txnId"],
        purchaseDate: DateTime.parse(json["purchase_date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "plan_id": List<dynamic>.from(planId!.map((x) => x)),
        "user_id": userId,
        "post_available": postAvailable,
        "end_date": endDate!.toIso8601String(),
        "post_ids": List<dynamic>.from(postIds!.map((x) => x)),
        "txnId": txnId,
        "purchase_date": purchaseDate!.toIso8601String(),
        "__v": v,
      };
}
