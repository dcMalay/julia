class AllBoost {
  AllBoost({
    required this.id,
    required this.boostSubcategory,
    required this.boostTitle,
    required this.boostRegprice,
    required this.boostDiscprice,
    required this.boostDuration,
    required this.v,
  });

  String id;
  String boostSubcategory;
  String boostTitle;
  int boostRegprice;
  int boostDiscprice;
  int boostDuration;
  int v;

  factory AllBoost.fromJson(Map<String, dynamic> json) => AllBoost(
        id: json["_id"],
        boostSubcategory: json["boost_subcategory"],
        boostTitle: json["boost_title"],
        boostRegprice: json["boost_regprice"],
        boostDiscprice: json["boost_discprice"],
        boostDuration: json["boost_duration"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "boost_subcategory": boostSubcategory,
        "boost_title": boostTitle,
        "boost_regprice": boostRegprice,
        "boost_discprice": boostDiscprice,
        "boost_duration": boostDuration,
        "__v": v,
      };
}
