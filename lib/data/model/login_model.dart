import 'dart:convert';

Email emailFromJson(String str) => Email.fromJson(json.decode(str));

String emailToJson(Email data) => json.encode(data.toJson());

class Email {
  Email({
    required this.emailSent,
  });

  bool emailSent;

  factory Email.fromJson(Map<String, dynamic> json) => Email(
        emailSent: json["Email sent"],
      );

  Map<String, dynamic> toJson() => {
        "Email sent": emailSent,
      };
}
