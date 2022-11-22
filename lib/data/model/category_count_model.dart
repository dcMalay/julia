class ProductsCountModel {
  ProductsCountModel({
    required this.id,
    required this.count,
  });

  String id;
  int count;

  factory ProductsCountModel.fromJson(Map<String, dynamic> json) =>
      ProductsCountModel(
        id: json["_id"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "count": count,
      };
}
