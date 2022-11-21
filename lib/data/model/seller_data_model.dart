class SellerDataModel {
  SellerDataModel({
    required this.data,
  });

  List<Datum> data;

  factory SellerDataModel.fromJson(Map<String, dynamic> json) =>
      SellerDataModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.userId,
    required this.userName,
    required this.userImage,
  });

  String userId;
  String userName;

  String userImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["user_id"],
        userName: json["user_name"],
        userImage: json["user_image"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "user_image": userImage,
      };
}
