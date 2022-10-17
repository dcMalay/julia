import 'dart:convert';

VerifyOtp verifyUserFromJson(String str) =>
    VerifyOtp.fromJson(json.decode(str));

String verifyUserToJson(VerifyOtp data) => json.encode(data.toJson());

class VerifyOtp {
  VerifyOtp({
    required this.userId,
    required this.token,
  });

  String userId;
  String token;

  factory VerifyOtp.fromJson(Map<String, dynamic> json) => VerifyOtp(
        userId: json["user_id"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "token": token,
      };
}
