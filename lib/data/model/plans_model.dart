// To parse this JSON data, do
//
//     final plans = plansFromJson(jsonString);

import 'dart:convert';

List<Plans> plansFromJson(String str) =>
    List<Plans>.from(json.decode(str).map((x) => Plans.fromJson(x)));

String plansToJson(List<Plans> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Plans {
  Plans({
    required this.id,
    required this.boostCategory,
    required this.boostSubcategory,
    required this.planName,
    required this.duration,
    required this.disprice,
    required this.postAvailable,
    required this.regprice,
    required this.v,
  });

  String id;
  String boostCategory;
  String boostSubcategory;
  String planName;
  int duration;
  String disprice;
  int postAvailable;
  String regprice;
  int v;

  factory Plans.fromJson(Map<String, dynamic> json) => Plans(
        id: json["_id"],
        boostCategory: json["boost_category"],
        boostSubcategory: json["boost_subcategory"],
        planName: json["plan_name"],
        duration: json["duration"],
        disprice: json["disprice"],
        postAvailable: json["post_available"],
        regprice: json["regprice"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "boost_category": boostCategory,
        "boost_subcategory": boostSubcategory,
        "plan_name": planName,
        "duration": duration,
        "disprice": disprice,
        "post_available": postAvailable,
        "regprice": regprice,
        "__v": v,
      };
}
