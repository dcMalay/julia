// To parse this JSON data, do
//
//     final boostMopeDetails = boostMopeDetailsFromJson(jsonString);

import 'dart:convert';

BoostMopeDetails boostMopeDetailsFromJson(String str) =>
    BoostMopeDetails.fromJson(json.decode(str));

String boostMopeDetailsToJson(BoostMopeDetails data) =>
    json.encode(data.toJson());

class BoostMopeDetails {
  BoostMopeDetails({
    required this.data,
  });

  Data data;

  factory BoostMopeDetails.fromJson(Map<String, dynamic> json) =>
      BoostMopeDetails(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.url,
  });

  String id;
  String url;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
