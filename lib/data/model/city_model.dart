// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

List<City> cityFromJson(String str) =>
    List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

String cityToJson(List<City> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class City {
  City({
    required this.id,
    required this.cityName,
    required this.parentLocation,
    required this.v,
  });

  String id;
  String cityName;
  String parentLocation;
  int v;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["_id"],
        cityName: json["city_name"],
        parentLocation: json["parent_location"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "city_name": cityName,
        "parent_location": parentLocation,
        "__v": v,
      };
}
