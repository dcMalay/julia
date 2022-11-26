

class UploadDataResponse {
  UploadDataResponse({
    required this.postUploaded,
  });

  PostUploaded postUploaded;

  factory UploadDataResponse.fromJson(Map<String, dynamic> json) =>
      UploadDataResponse(
        postUploaded: PostUploaded.fromJson(json["post uploaded"]),
      );

  Map<String, dynamic> toJson() => {
        "post uploaded": postUploaded.toJson(),
      };
}

class PostUploaded {
  PostUploaded({
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
    required this.id,
    required this.postDate,
    required this.v,
  });

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
  String id;
  DateTime postDate;
  int v;

  factory PostUploaded.fromJson(Map<String, dynamic> json) => PostUploaded(
        postCategory: json["post_category"],
        postSubcategory: json["post_subcategory"],
        postStatus: json["post_status"],
        postUserId: json["post_user_id"],
        postFeatured: json["post_featured"],
        postLocation: json["post_location"],
        postCity: json["post_city"],
        fields: json["fields"],
        postTitle: json["post_title"],
        postImage: List<String>.from(json["post_image"].map((x) => x)),
        postSold: json["post_sold"],
        postPrice: json["post_price"],
        postDescription: json["post_description"],
        authName: json["auth_name"],
        id: json["_id"],
        postDate: DateTime.parse(json["post_date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "post_category": postCategory,
        "post_subcategory": postSubcategory,
        "post_status": postStatus,
        "post_user_id": postUserId,
        "post_featured": postFeatured,
        "post_location": postLocation,
        "post_city": postCity,
        "fields": fields,
        "post_title": postTitle,
        "post_image": List<dynamic>.from(postImage.map((x) => x)),
        "post_sold": postSold,
        "post_price": postPrice,
        "post_description": postDescription,
        "auth_name": authName,
        "_id": id,
        "post_date": postDate.toIso8601String(),
        "__v": v,
      };
}
