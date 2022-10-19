import 'dart:convert';

List<SubCategories> subcategoryFromJson(String str) => List<SubCategories>.from(
    json.decode(str).map((x) => SubCategories.fromJson(x)));

String subcategoryToJson(List<SubCategories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategories {
  SubCategories({
    required this.id,
    required this.postSubcategoryName,
    required this.postParentCatagory,
    required this.v,
  });

  String id;
  String postSubcategoryName;
  String postParentCatagory;
  int v;

  factory SubCategories.fromJson(Map<String, dynamic> json) => SubCategories(
        id: json["_id"],
        postSubcategoryName: json["post_subcategory_name"],
        postParentCatagory: json["post_parent_catagory"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "post_subcategory_name": postSubcategoryName,
        "post_parent_catagory": postParentCatagory,
        "__v": v,
      };
}
