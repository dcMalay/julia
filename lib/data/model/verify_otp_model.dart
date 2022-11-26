import 'dart:convert';

VerifyModel verifyUserFromJson(String str) =>
    VerifyModel.fromJson(json.decode(str));

String verifyUserToJson(VerifyModel data) => json.encode(data.toJson());

class VerifyModel {
  VerifyModel({
    required this.userId,
    required this.token,
  });

  String userId;
  String token;

  factory VerifyModel.fromJson(Map<String, dynamic> json) => VerifyModel(
        userId: json["user_id"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "token": token,
      };
}
