class Myads {
  Myads({
    required this.id,
    required this.postCategory,
    required this.postSubcategory,
    required this.postStatus,
    required this.postUserId,
    required this.postFeatured,
    required this.postLocation,
    required this.postCity,
    required this.fields,
    required this.postTitle,
    required this.postImage,
    required this.postSold,
    required this.postPrice,
    required this.postDescription,
    required this.authName,
    required this.postDate,
    required this.v,
  });

  String id;
  String postCategory;
  String postSubcategory;
  String postStatus;
  String postUserId;
  int postFeatured;
  String postLocation;
  String postCity;
  String fields;
  String postTitle;
  List<String> postImage;
  String postSold;
  int postPrice;
  String postDescription;
  String authName;
  DateTime postDate;
  int v;

  factory Myads.fromJson(Map<String, dynamic> json) => Myads(
        id: json["_id"],
        postCategory: json["post_category"],
        postSubcategory: json["post_subcategory"],
        postStatus: json["post_status"],
        postUserId: json["post_user_id"]!,
        postFeatured: json["post_featured"],
        postLocation: json["post_location"],
        postCity: json["post_city"],
        fields: json["fields"],
        postTitle: json["post_title"],
        postImage: List<String>.from(json["post_image"].map((x) => x)),
        postSold: json["post_sold"],
        postPrice: json["post_price"],
        postDescription: json["post_description"]!,
        authName: json["auth_name"],
        postDate: DateTime.parse(json["post_date"]),
        v: json["__v"],
      );
}
