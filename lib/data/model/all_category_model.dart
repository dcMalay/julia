class AllCategory {
  AllCategory({
    this.id,
    this.postCategoryName,
    this.v,
  });

  String? id;
  String? postCategoryName;
  int? v;

  factory AllCategory.fromJson(Map<String, dynamic> json) => AllCategory(
        id: json["_id"],
        postCategoryName: json["post_category_name"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "post_category_name": postCategoryName,
        "__v": v,
      };
}
